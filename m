Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbUJ1Vym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUJ1Vym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUJ1VvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:51:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5627 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263013AbUJ1Vuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:50:39 -0400
Message-ID: <418169A7.3000308@mvista.com>
Date: Thu, 28 Oct 2004 14:50:31 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lei Yang <lya755@ece.northwestern.edu>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: set blksize of block device
References: <417FE6A8.5090803@ece.northwestern.edu> <41804F04.4000300@ece.northwestern.edu> <418058A8.5080706@ece.northwestern.edu> <200410280911.15756.vda@port.imtp.ilyichevsk.odessa.ua> <418162A6.80808@ece.northwestern.edu>
In-Reply-To: <418162A6.80808@ece.northwestern.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lei Yang wrote:
> Denis Vlasenko wrote:
...
>> Can you use read, write and seek system calls?
...
> Not really, as I've explained, I want to do all these stuff in kernel 
> space. More specifically, I want to write a newbie kernel module. In 
> this module, I'll do something with a raw block device (with no 
> filesystem). For example, I want to do block I/O operations on ramdisk, 
> and I want to set the block size of ramdisk to whatever value I want 
> (power of 2 of course).

Pick up a copy of Linux Device Drivers by Rubini & Corbet (O'Reilly, 
2001) and start with the example ramdisk block driver in chapter 12.

-- 
Todd
