Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131610AbQJ2Kki>; Sun, 29 Oct 2000 05:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131621AbQJ2Kk3>; Sun, 29 Oct 2000 05:40:29 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:24591 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131610AbQJ2KkU>; Sun, 29 Oct 2000 05:40:20 -0500
Date: Sun, 29 Oct 2000 04:40:08 -0600
To: Wakko Warner <wakko@animx.eu.org>
Cc: Igmar Palsenberg <maillist@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock
Message-ID: <20001029044008.A14922@wire.cadcamlab.org>
In-Reply-To: <20001025171255.26384.qmail@web6104.mail.yahoo.com> <Pine.LNX.4.21.0010261534490.9868-100000@server.serve.me.nl> <20001026121958.A18594@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001026121958.A18594@animx.eu.org>; from wakko@animx.eu.org on Thu, Oct 26, 2000 at 12:19:58PM -0400
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Wakko Warner]
> While this subject is fresh, what would be wrong with using the
> entire drive as opposed to creating a partition and adding the
> partition to the raid?

Does it autodetect an entire drive?  The autodetect logic for
partitions looks at the 'partition type' byte, which of course doesn't
exist for a whole drive.

Just a thought .. I don't run RAID here.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
