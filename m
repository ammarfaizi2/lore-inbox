Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbTCJVRq>; Mon, 10 Mar 2003 16:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbTCJVRq>; Mon, 10 Mar 2003 16:17:46 -0500
Received: from ns.suse.de ([213.95.15.193]:49423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261472AbTCJVRp>;
	Mon, 10 Mar 2003 16:17:45 -0500
To: John Bradford <john@grabjohn.com>
Cc: phillips@arcor.de (Daniel Phillips), ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tytso@mit.edu, adilger@clusterfs.com,
       chrisl@vmware.com, bzzz@tmi.comex.ru
Subject: Re: [RFC] Improved inode number allocation for HTree
X-Yow: Talking Pinhead Blues:
 Oh, I LOST my ``HELLO KITTY'' DOLL and I get BAD reception on
  channel TWENTY-SIX!!
 Th'HOSTESS FACTORY is closin' down and I just heard ZASU PITTS
  has been DEAD for YEARS..  (sniff)
 My PLATFORM SHOE collection was CHEWED up by th'dog, ALEXANDER
  HAIG won't let me take a SHOWER 'til Easter.. (snurf)
 So I went to the kitchen, but WALNUT PANELING whup me
  upside mah HAID!! (on no, no, no..  Heh, heh)
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 10 Mar 2003 22:28:25 +0100
In-Reply-To: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk> (John
 Bradford's message of "Mon, 10 Mar 2003 21:04:03 +0000 (GMT)")
Message-ID: <jebs0iq5c6.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

|> > Though the journal only becomes involved when blocks are modified,
|> > unfortunately, because of atime updates, this includes all directory
|> > operations.  We could suggest to users that they should disable
|> > atime updating if they care about performance, but we ought to be
|> > able to do better than that.
|> 
|> On a separate note, since atime updates are not usually very important
|> anyway, why not have an option to cache atime updates for a long time,
|> or until either a write occurs anyway.

mount -o noatime

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
