Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131351AbRBDGmQ>; Sun, 4 Feb 2001 01:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131475AbRBDGmG>; Sun, 4 Feb 2001 01:42:06 -0500
Received: from mail.diligo.fr ([194.153.78.251]:35082 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S131351AbRBDGlw>;
	Sun, 4 Feb 2001 01:41:52 -0500
Date: Sun, 4 Feb 2001 07:38:06 +0100
From: patrick.mourlhon@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
Message-ID: <20010204073806.D529@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be happy, it was not that simple. ;-)

On Sat, 03 Feb 2001, Bob_Tracy wrote:

> patrick.mourlhon@wanadoo.fr wrote:
> > ----mount atapi cd writer outpu
> > 
> > Line:/mnt/home/pmo# mount /dev/hdb /cdrom
> > /dev/hdb: Input/output error
> > mount: block device /dev/hdb is write-protected, mounting read-only
> > /dev/hdb: Input/output error
> > 
> > mount: you must specify the filesystem type
> > Line:/mnt/home/pmo#
> 
> I'd hate to think your problem is *really* this simple, but if you
> really typed what is quoted above, and the CD you have in the drive
> really has something valid on it, try the following instead:
> 
> mount -t iso9660 /dev/hdb /cdrom -r
> 
> You have to specify the filesystem type, as well as specify the
> "readonly" flag.  Although there are other filesystem types that
> can be found on CDROMs, it's unlikely in your case.
> 
> --Bob Tracy
> rct@frus.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
