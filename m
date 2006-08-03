Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWHCQvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWHCQvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWHCQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:51:44 -0400
Received: from thunk.org ([69.25.196.29]:49026 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932362AbWHCQvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:51:44 -0400
Date: Thu, 3 Aug 2006 12:50:31 -0400
From: Theodore Tso <tytso@mit.edu>
To: Ric Wheeler <ric@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, linux-kernel@vger.kernel.org,
       wayned@samba.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060803165031.GC20603@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Ric Wheeler <ric@emc.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
	reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
	rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
	lkml@lpbproductions.com, jeff@garzik.org,
	linux-kernel@vger.kernel.org, wayned@samba.org
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <20060803140307.GB7431@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803140307.GB7431@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:03:07PM +0200, Matthias Andree wrote:
> On Tue, 01 Aug 2006, Ric Wheeler wrote:
> 
> > Mirroring a corrupt file system to a remote data center will mirror your 
> > corruption.
> > 
> 
> Which makes me wonder if backup systems shouldn't help with this. If
> they are reading the whole file anyways, they can easily compute strong
> checksums as they go, and record them for later use, and check so many
> percent of unchanged files every day to complain about corruptions.

They absolutely should do this sort of thing.

Also sounds like yet another option that could be added to rsync.
(Only half-joking.  :-)

						- Ted
