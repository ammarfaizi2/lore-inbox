Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269658AbRHAGVk>; Wed, 1 Aug 2001 02:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269657AbRHAGVa>; Wed, 1 Aug 2001 02:21:30 -0400
Received: from zeus.kernel.org ([209.10.41.242]:24808 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269656AbRHAGVW>;
	Wed, 1 Aug 2001 02:21:22 -0400
Date: Mon, 30 Jul 2001 08:37:07 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>
Message-ID: <Pine.LNX.4.33.0107300830010.2749-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Andrew Morton wrote:

> An update to the ext3 filesystem for 2.4 kernels is available at
>
> 	http://www.uow.edu.au/~andrewm/linux/ext3/
I'm using ext3-0.9.4 with linux-2.4.7 / 2.4.8-pre1 and get some hangs on
my dual P2-350:
>From time to time I will have multiple CRON-Daemons in D-state and login
hangs when logging in. It even happens during boot before my MTA is
started.

I have a single ext3 partition which is exported by kernel-nfs-server.

As soon as I do an Alt-SysRq-S forced sync the hang goes away and
everything works normal.

If you need further information send me an eMail. SGIs kdb is already
compiled in so if we need it ...

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

