Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbUKTEkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbUKTEkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbUKTEef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:34:35 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:49912 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261432AbUKTEdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:33:14 -0500
Message-ID: <419EC91D.5030907@verizon.net>
Date: Fri, 19 Nov 2004 23:33:33 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] floppy: Reorganize drivers/block/floppy.c
References: <20041105014000.11993.38553.30904@localhost.localdomain> <20041119223142.GJ2202@stro.at>
In-Reply-To: <20041119223142.GJ2202@stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Fri, 19 Nov 2004 22:33:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> On Thu, 04 Nov 2004, james4765@verizon.net wrote:
> 
> 
>>Organization of global variables, macros, and #defines in floppy.c
>>
>>Signed-off-by: James Nelson <james4765@gmail.com>
>>
>>diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
>>--- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
>>+++ linux-2.6.9/drivers/block/floppy.c	2004-11-04 20:25:28.180478012 -0500
> 
> 
> hmm could you split up your patch in logical hunks?

Well, it won't apply to 2.6.10-rc2 anyway (sone ACPI stuff was added), so it 
wouldn't be any less work to re-do it ;)

I guess I'll just take it in smaller chunks, then - spread out over a few -rc's.

> nitpicking: your patch adds whitespace.
> 
> a++ maks
> -
> 

