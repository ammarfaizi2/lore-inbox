Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292447AbSBZRqV>; Tue, 26 Feb 2002 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSBZRpt>; Tue, 26 Feb 2002 12:45:49 -0500
Received: from mail.sonytel.be ([193.74.243.200]:31165 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S292467AbSBZRp1>;
	Tue, 26 Feb 2002 12:45:27 -0500
Date: Tue, 26 Feb 2002 18:45:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
In-Reply-To: <3C751CB2.52110E58@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0202261842290.8085-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:
> Comments welcome...

| Submitting Changes to Linus
| ---------------------------

  [...]

| 2) Include an Internet-available URL for Linus to pull from, such as
| 
| 	Pull from:  http://gkernel.bkbits.net/net-drivers-2.5
| 
| 
| 
| 3) Include a summary and "diffstat -p1" of each changeset that will be
| downloaded, when Linus issues a "bk pull".  The author auto-generates
| these summaries using "bk push -nl <parent> 2>&1", to obtain a listing
| of all the pending-to-send changesets, and their commit messages.
| 
| It is important to show Linus what he will be downloading when he issues
| a "bk pull", to reduce the time required to sift the changes once they
| are downloaded to Linus's local machine.
| 
| IMPORTANT NOTE:  One of the features of BK is that your repository does
| not have to be up to date, in order for Linus to receive your changes.
| It is considered a courtesy to keep your repository fairly recent, to
| lessen any potential merge work Linus may need to do.
| 
| 
| 4) Split up your changes.  Each maintainer<->Linus situation is likely
| to be slightly different here, so take this just as general advice.  The
| author splits up changes according to "themes" when merging with Linus.
| Simultaneous pushes from local development to goes special trees which
| exist solely to house changes "queued" for Linus.  Example of the trees:
| 
| 	net-drivers-2.5 -- on-going net driver maintenance
| 	vm-2.5 -- VM-related changes
| 	fs-2.5 -- filesystem-related changes
| 
| Linus then has much more freedom for pulling changes.  He could (for
| example) issue a "bk pull" on vm-2.5 and fs-2.5 trees, to merge their
| changes, but hold off net-drivers-2.5 because of a change that needs
| more discussion.
| 
| Other maintainers may find that a single linus-pull-from tree is
| adequate for passing BK changesets to him.

So what if Linus isn't happy with the changes you made in the for-Him-to-pull
tree? How do I back off (part of the changes)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

