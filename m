Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131616AbQJ2Mnc>; Sun, 29 Oct 2000 07:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131663AbQJ2MnW>; Sun, 29 Oct 2000 07:43:22 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:2831
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S131616AbQJ2MnP>; Sun, 29 Oct 2000 07:43:15 -0500
Date: Sun, 29 Oct 2000 07:52:35 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock
Message-ID: <20001029075235.A1773@animx.eu.org>
In-Reply-To: <20001029044008.A14922@wire.cadcamlab.org> <Pine.LNX.4.21.0010291435190.14790-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0010291435190.14790-100000@server.serve.me.nl>; from Igmar Palsenberg on Sun, Oct 29, 2000 at 02:36:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [Wakko Warner]
> > > While this subject is fresh, what would be wrong with using the
> > > entire drive as opposed to creating a partition and adding the
> > > partition to the raid?
> > 
> > Does it autodetect an entire drive?  The autodetect logic for
> > partitions looks at the 'partition type' byte, which of course doesn't
> > exist for a whole drive.

Actually, I don't think it does.  I've not booted into single user mode
(where the raid hasn'tbeen setup yet) to see.

> > Just a thought .. I don't run RAID here.
> 
> A good one. I seriously doubt that it indeed will detect drives. The're
> not partitions, the're drives.
> 
> Don't think the current RAID code handles entire drives. 

Autodetect, probably not.  But it doesn't seem to have any problems with it
as far as usability.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
