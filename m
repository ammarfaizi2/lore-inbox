Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSFTTOs>; Thu, 20 Jun 2002 15:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSFTTOr>; Thu, 20 Jun 2002 15:14:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4115 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315388AbSFTTOq>; Thu, 20 Jun 2002 15:14:46 -0400
Date: Thu, 20 Jun 2002 12:15:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Patrick Mansfield <patmans@us.ibm.com>, Andries Brouwer <aebr@win.tue.nl>,
       Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map 
In-Reply-To: <200206201852.g5KIqoJ06342@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206201210420.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, James Bottomley wrote:
>
> We should probably have some more discussion about the layout of the device
> tree, particularly if it's going to be consistent with other devices like ide
> discs and cds.

Absolutely. I suspect that the _real_ issues start coming up only once
people start using this for useful work, and we should just accept that
the format (for now) is in flux. But that doesn't mean that we shouldn't
try to make it reasonably sane from the very start.

And make sure that the naming convention works for both IDE and SCSI (ie
there should be a way to figure out _portably_ whether a device is a disk
or CD-RW or whatever, without even knowing whether it's SCSI or IDE).

			Linus

