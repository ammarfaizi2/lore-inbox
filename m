Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSIBWxo>; Mon, 2 Sep 2002 18:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSIBWxo>; Mon, 2 Sep 2002 18:53:44 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:41426 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318526AbSIBWxo>; Mon, 2 Sep 2002 18:53:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Hacksaw <hacksaw@hacksaw.org>,
       Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Date: Tue, 3 Sep 2002 00:57:01 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <200209022233.g82MXXgB015673@habitrail.home.fools-errant.com>
In-Reply-To: <200209022233.g82MXXgB015673@habitrail.home.fools-errant.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <17m085-0bF1fsC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. September 2002 00:33 schrieb Hacksaw:
> Speaking from the perspective of a long time computer user and sys-admin,
> I'm trying to understand life without a partition table.
>
> I operate under the following assumptions:
>
> 1. It's useful to have a physical disk divided into multiple logical disks.

It's not only useful, without it there can be no cooperation among
operating systems. There are standards which have to be followed.

Partition detection has to work always and everywhere.
It has to work if you have booted into /bin/bash and half your
disk is gone and you're busily hacking away with a disk editor.

[..]
> Of course, I'd be the first to admit that the current partition table is a
> stupid design, but I can't see not having one at all.

It's not the only design.

	Regards
		Oliver
