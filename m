Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132991AbRDKU1w>; Wed, 11 Apr 2001 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132992AbRDKU1m>; Wed, 11 Apr 2001 16:27:42 -0400
Received: from ns.caldera.de ([212.34.180.1]:12553 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132990AbRDKU1a>;
	Wed, 11 Apr 2001 16:27:30 -0400
Date: Wed, 11 Apr 2001 22:27:22 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010411222722.A31359@caldera.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	"Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <200104112004.WAA30164@ns.caldera.de> <Pine.LNX.4.30.0104112212310.29627-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0104112212310.29627-100000@Appserv.suse.de>; from davej@suse.de on Wed, Apr 11, 2001 at 10:16:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 10:16:36PM +0200, Dave Jones wrote:
> On Wed, 11 Apr 2001, Christoph Hellwig wrote:
> 
> > > CML2 takes around 15 seconds before I get that far.
> > > This is on an Athlon 800 w/512MB. I dread to think how this
> > > responds on a 486.
> >
> > If you look for something _even_ faster try mconfig.  For everyone who is
> > interested, I've put my latests half-way stable version is on ftp.  It's at
> >   ftp.openlinux.org:/pub/people/hch/mconfig/mconfig-0.19-pre1.tar.gz
> > Props for all the hard work go to Michael Elizabeth Chastain!
> 
> This is the first I've heard of mconfig. (I don't track the kbuild list)
> Does it solve all the problems that Eric's solution proposes?
> It's certainly fast (CML1 menuconfig speed at least).

Not all (yet).
o It is one programm with multiple frontends:
	old,
	text,
	ncurses,
	random,
	maximum,
	minimum,
	syntax checking
	(X is still missing as my brain is not made for GUI programming)

o An 'show me all options and handle the rest' mode is still missing -
  my devel tree has something like that in the works, but I'll probably
  never finish it now that CML2 is official.

o it still has multiple top-level config.in.  Again that is easily fixable
  and in fact I did a patch for it (including {old,menu,x}config support
  in 2.3 times but never submitted it.

Something missing?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
