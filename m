Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268724AbUIGWxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268724AbUIGWxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUIGWxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:53:52 -0400
Received: from cardinal.mail.pas.earthlink.net ([207.217.121.226]:36248 "EHLO
	cardinal.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S268724AbUIGWxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:53:48 -0400
Message-ID: <017201c4952d$016723a0$1225a8c0@kittycat>
From: "jdow" <jdow@earthlink.net>
To: "Thomas Richter" <thor@math.TU-Berlin.DE>, <linux-kernel@vger.kernel.org>
References: <200409071547.RAA03166@cleopatra.math.tu-berlin.de>
Subject: Re: [PATCH] Amiga partition fix
Date: Tue, 7 Sep 2004 15:50:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received an email saying the patch was approved. I'm not sure when
that means it will find its way into the kernel.
{^_^}
----- Original Message ----- 
From: "Thomas Richter" <thor@math.TU-Berlin.DE>


> 
> Hi,
> 
> what happened to Joanne Dow's patch to fix the recognition of
> Amiga RDSK blocks? In case that got lost, here's the patch again:
> 
> /* snip */
> 
> --- amiga.c 2004-08-09 08:52:07.268123677 -0700
> +++ amiga.c.orig 2004-08-09 08:51:31.527104456 -0700
> @@ -31,7 +31,6 @@ amiga_partition(struct parsed_partitions
>   struct RigidDiskBlock *rdb;
>   struct PartitionBlock *pb;
>   int start_sect, nr_sects, blk, part, res = 0;
> - int blksize = 1; /* Multiplier for disk block size */
>   int slot = 1;
>   char b[BDEVNAME_SIZE];


