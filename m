Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWACF7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWACF7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 00:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWACF7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 00:59:00 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62333 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751167AbWACF67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 00:58:59 -0500
Date: Mon, 02 Jan 2006 23:58:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: P-D x86_64: "trap invalid operand" kernel messages
In-reply-to: <5qN44-8oA-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43BA129F.3020302@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5qN44-8oA-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rodney Gordon II wrote:
> I can reproduce consistantly a kernel trap message when using
> the app "transcode".
> 
> They all look similar to this:
> transcode[27576] trap invalid operand rip:2aaaae2c5990
> rsp:7fffff8e7548 error:0
> 
> Is this kernel related, or a bug in the application?

The program seems to be executing an illegal instruction - likely either 
an application bug or it is compiled for the wrong CPU and using 
unsupported instructions.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

