Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSFTXQV>; Thu, 20 Jun 2002 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315792AbSFTXQV>; Thu, 20 Jun 2002 19:16:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26387 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315783AbSFTXQU>; Thu, 20 Jun 2002 19:16:20 -0400
Date: Thu, 20 Jun 2002 16:13:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwenke <martin@meltin.net>
cc: Andries Brouwer <aebr@win.tue.nl>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <200206202259.IAA01298@thucydides.inspired.net.au>
Message-ID: <Pine.LNX.4.33.0206201608510.1222-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Jun 2002, Martin Schwenke wrote:
>
> Does it have to be limited ot information that the kernel already has?

No, but on the other hand I don't want the filesystem to be a bloat thing.

Right now all the filesystem code is basically just the regular dentry
tree (same as ramfs etc). And the data structures are largely data
structures that we have to carry around anyway. 

Bit if somehting is really _useful_ to export to user space through the fs
model and it makes things easier, that's probably good. Naming is
definitely one of those things - I generally like how the thing looks in a
file managers tree-view, but some of the names suck and that shows up cery 
clearly at that point, liiking in at 10.000'.

(Tha ACPI "shouting disease" is really sad. I remember my old VIC-20, and
how you used all-caps, but I don't think the ACPI people were sentimental.  
They apparently just _like_ ugly four-letter ALL-CAPS names).

		Linus

