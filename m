Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUAYUGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUAYUGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:06:33 -0500
Received: from mail.broadpark.no ([217.13.4.2]:9961 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265256AbUAYUGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:06:32 -0500
Message-ID: <001b01c3e37e$b9d3b630$1e00000a@black>
From: "Daniel Andersen" <kernel-list@majorstua.net>
To: "Mike Keehan" <mike_keehan@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20040125194329.59773.qmail@web12304.mail.yahoo.com>
Subject: Re: 2.6.2-rc1-bk3 patch fails
Date: Sun, 25 Jan 2004 21:06:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Applying the above patch to 2.6.1 gets failure in:-
> 
> . Makefile
> . arch/i386/kernel/cpu/mcheck/non-fatal.c
> . drivers/cdrom/cdrom.c
> . drivers/input/joydev.c
> . drivers/input/keyboard/atkbd.c
> . drivers/md/Kconfig
> . drivers/md/raid6.h  (doesn't exist)
> 
> I control C'd out of the rest.  The BK snapshots on 
> kernel.org aren't meant to be applied cumulatively, 
> are they?

You must apply the 2.6.2-rc1 patch first. Then you can patch with -bk3.

Daniel Andersen
