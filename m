Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWBJLr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWBJLr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBJLr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:47:26 -0500
Received: from mail.gmx.de ([213.165.64.21]:40603 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751078AbWBJLrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:47:25 -0500
X-Authenticated: #428038
Date: Fri, 10 Feb 2006 12:47:21 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210114721.GB20093@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mj@ucw.cz, peter.read@gmail.com, linux-kernel@vger.kernel.org,
	jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC71FB.nailISD31LRCB@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-10:

> Martin Mares <mj@ucw.cz> wrote:
> 
> > Hello!
> >
> > > This is why the mapping engine is in the Linux adoption part of
> > > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > > stable b,t,l address.
> >
> > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> 
> Dou you like to verify that you have no clue on SCSI?

How does, for instance, libscg make sure that the b,t,l mappings are
hotplug invariant?

How does libscg make sure that two external writers, say USB, retain
their b,t,l mappings if both are unplugged and then replugged in reverse
order, perhaps into different USB hubs?

What assumptions does libscg (or cdrecord) make to procure stable
mappings?

You complained the discussion were non-technical, yet rather than
correcting false information at detail scale, you resort to personal
insults, and I think you're standing on pretty thin ice with those
attacks. Your credibility is about to reach zero.

-- 
Matthias Andree
