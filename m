Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSKMVy2>; Wed, 13 Nov 2002 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSKMVy2>; Wed, 13 Nov 2002 16:54:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42627 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264646AbSKMVy1>; Wed, 13 Nov 2002 16:54:27 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211132201.gADM1Fw09895@devserv.devel.redhat.com>
Subject: Re: sysfs support for ide disks
To: pavel@ucw.cz (Pavel Machek)
Date: Wed, 13 Nov 2002 17:01:15 -0500 (EST)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20021113215618.GA8744@elf.ucw.cz> from "Pavel Machek" at Nov 13, 2002 10:56:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had to select between standby written in ide-disk.c (uses
> ide_raw_taskfile) and standby written in sc1200.c (uses
> ide_wait_cmd). I do not know which one is correct, but I tend to trust
> ide-disk.c version a bit more, and used that.

They'll both ultimately do the same thing.

> Apply if it looks good to you,

Ok will do. My only gripe is about printk levels this time 8)

