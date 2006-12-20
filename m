Return-Path: <linux-kernel-owner+w=401wt.eu-S964830AbWLTD3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWLTD3u (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWLTD3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:29:49 -0500
Received: from pyxis.i-cable.com ([203.83.115.105]:46805 "HELO
	pyxis.i-cable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964836AbWLTD3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:29:48 -0500
Message-ID: <002901c723e6$f54860c0$28df0f3d@kylecea1512a3f>
From: "kyle" <kylewong@southa.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: <linux-kernel@vger.kernel.org>
References: <fa.n+5Mb4OrI3NXIfyW+9Do6h0Q2UA@ifi.uio.no> <45874FC3.503@shaw.ca>
Subject: Re: schedule_timeout: wrong timeout value
Date: Wed, 20 Dec 2006 11:28:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Robert Hancock" <hancockr@shaw.ca>
To: "kyle" <kylewong@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 19, 2006 10:34 AM
Subject: Re: schedule_timeout: wrong timeout value


> kyle wrote:
>> Hi,
>>
>> Recently my mysql servershows something like:
>> Dec 18 18:24:05 sql kernel: schedule_timeout: wrong timeout value 
>> ffffffff from c0284efd
>> Dec 18 18:24:36 sql last message repeated 19939 times
>> Dec 18 18:25:37 sql last message repeated 33392 times
>>

> The message means some code in the kernel or in some module passed a 
> negative value to schedule_timeout which it shouldn't have. The c0284efd 
> value is the address of the function that made the call - you may be able 
> to look that up in your /proc/ksyms or the System.map file and figure out 
> what function that is..

There was no module loaded, and unfortunlately, I cannot find the System.map 
or /proc/ksyms file for the affected kernel!
Anyway thank you for your explanation. I have upgraded the kernel to 
2.6.17.14 and wish that it can fix the problem. Thank you

Kyle 

