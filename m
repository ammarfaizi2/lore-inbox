Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVBZSpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVBZSpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVBZSpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:45:25 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:47040 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261258AbVBZSpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:45:20 -0500
Message-ID: <4220C3C8.1060705@euroweb.net.mt>
Date: Sat, 26 Feb 2005 19:45:28 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: System call problem
References: <42208509.3080201@euroweb.net.mt> <1109429016.1452.48.camel@localhost.localdomain>
In-Reply-To: <1109429016.1452.48.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Sat, 2005-02-26 at 15:17 +0100, Josef E. Galea wrote:
>
>  
>
>>I compiled and booted the kernel and am trying to build a user space 
>>application that uses my system call, however gcc is returning this error:
>>/tmp/cc4zgzUr.o(.text+0x4e): In functiono `get_rmt_paging':
>>: undefined reference to `errno'
>>
>>    
>>
>
>Where you defined your system call in the user space program (ie. where
>you declared your _syscall macro), did you also include <errno.h>?
>
>-- Steve
>
>
>  
>
I included <linux/errno.h> and it didn't solve the problem. Now i 
included <errno.h> and it did. Thanks for you help!

Josef
