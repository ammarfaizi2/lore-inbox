Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131032AbQJ2M3I>; Sun, 29 Oct 2000 07:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131667AbQJ2M26>; Sun, 29 Oct 2000 07:28:58 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:58911 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131032AbQJ2M2r>; Sun, 29 Oct 2000 07:28:47 -0500
Date: Sun, 29 Oct 2000 14:36:44 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock
In-Reply-To: <20001029044008.A14922@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0010291435190.14790-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2000, Peter Samuelson wrote:

> [Wakko Warner]
> > While this subject is fresh, what would be wrong with using the
> > entire drive as opposed to creating a partition and adding the
> > partition to the raid?
> 
> Does it autodetect an entire drive?  The autodetect logic for
> partitions looks at the 'partition type' byte, which of course doesn't
> exist for a whole drive.
> 
> Just a thought .. I don't run RAID here.

A good one. I seriously doubt that it indeed will detect drives. The're
not partitions, the're drives.

Don't think the current RAID code handles entire drives. 



		Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
