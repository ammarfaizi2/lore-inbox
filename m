Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284370AbRLRR4b>; Tue, 18 Dec 2001 12:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284386AbRLRR4V>; Tue, 18 Dec 2001 12:56:21 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31217 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284370AbRLRR4I>;
	Tue, 18 Dec 2001 12:56:08 -0500
Date: Tue, 18 Dec 2001 10:54:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Mansfield <david@cobite.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
Message-ID: <20011218105459.X855@lynx.no>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	David Mansfield <david@cobite.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Dec 18, 2001 at 09:27:29AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 18, 2001  09:27 -0800, Linus Torvalds wrote:
> Maybe the best thing to do is to educate the people who write the sound
> apps for Linux (somebody was complaining about "esd" triggering this, for
> example).

Yes, esd is an interrupt hog, it seems.  When reading this thread, I
checked, and sure enough I was getting 190 interrupts/sec on the
sound card while not playing any sound.  I killed esd (which I don't
use anyways), and interrupts went to 0/sec when not playing sound.
Still at 190/sec when using mpg123 on my ymfpci (Yamaha YMF744B DS-1S)
sound card.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

