Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVD3Tzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVD3Tzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 15:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVD3Tzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 15:55:49 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24419 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261385AbVD3Tzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 15:55:44 -0400
Date: Sat, 30 Apr 2005 13:55:39 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: HyperThreading, kernel 2.6.10, 1 logical CPU idle !!
In-reply-to: <3Z3u8-28Z-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4273E2BB.9010509@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Z3u8-28Z-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Fersing wrote:
> Hi there, 
> 
> I've a p4 HT 3,06Ghz, I've HT enabled in the BIOS and in the kernel :
> 
> Linux electron 2.6.10-cj5 #6 SMP Fri Mar 4 02:18:08 CET 2005 i686 Mobile
> Intel(R) Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux .
> 
> But it seems that one of my cpus is idle (gkrellm monitor or top) :
> 
> Cpu0  : 88.0% us, 12.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,
> 0.0% si
> Cpu1  :  0.0% us,  0.3% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,
> 0.0% si
> 
> 
> I'm actually compiling thunderbird with MAKEOPTS="-j3", so , the second
> should be used, shouldn't it ?

Are you sure that it is actually compiling multiple files at once?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

