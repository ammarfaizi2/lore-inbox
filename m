Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUJXSK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUJXSK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUJXSK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:10:59 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:15007 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261568AbUJXSKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:10:54 -0400
Message-ID: <417BF02F.20704@arcor.de>
Date: Sun, 24 Oct 2004 20:10:55 +0200
From: Thomas Meyer <thomas.mey3r@arcor.de>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1] Segmentation fault in program "X"
References: <417B6A17.8010904@arcor.de> <200410241313.31151.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410241313.31151.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:
> On Sunday 24 October 2004 11:38, Thomas Meyer wrote:
> 
>>Hello.
>>
>>X doesn't work under 2.6.10-rc1. i'm using the framebuffer X server. 
>>Kernel 2.6.9 works. How could that be?
> 
> 
> Details?
> --
> vda
> 
> 

Hi.

Signal SIGSEGV happens while doing sys function
"ioctl(5, FBIOBLANK <unfinished ...>"

seems to be some changes between 2.6.9 and 2.6.10-rc1 in file "fbmem.c"

with kind regards
Thomas

