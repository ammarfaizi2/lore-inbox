Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUGAOlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUGAOlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUGAOlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:41:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50573 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265530AbUGAOlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:41:23 -0400
Date: Thu, 1 Jul 2004 10:40:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jan De Luyck <lkml@kcore.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7] SCSI trouble with Adaptec 29160N
In-Reply-To: <200407011614.47326.lkml@kcore.org>
Message-ID: <Pine.LNX.4.53.0407011037510.13654@chaos>
References: <200407011614.47326.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Jan De Luyck wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hello list,
>
> Running kernel 2.6.7.
>
> I found this in the logs today after not being able to access my /mnt/dump disk, which is normally mounted to /dev/sdb1
> I'm wondering if this is a hardware problem, and if so, is it the disc or the controller? Google wasn't particulary helpful.

My bet is that you connected a fast SCSI cable without a terminator
on its end.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


