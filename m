Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVKVEME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVKVEME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 23:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVKVEME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 23:12:04 -0500
Received: from mail.suse.de ([195.135.220.2]:5312 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932091AbVKVEMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 23:12:03 -0500
From: Neil Brown <neilb@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Date: Tue, 22 Nov 2005 15:11:52 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.39560.978065.606788@cse.unsw.edu.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
In-Reply-To: message from Jon Smirl on Monday November 21
References: <20051121225303.GA19212@kroah.com>
	<20051121230136.GB19212@kroah.com>
	<1132616132.26560.62.camel@gaston>
	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	<1132623268.20233.14.camel@localhost.localdomain>
	<1132626478.26560.104.camel@gaston>
	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 21, jonsmirl@gmail.com wrote:
> 
> 2) Temporarily accept the ugly drivers. Let desktop development
> continue. Work hard on getting the vendors to see the light and go
> open source.

I doubt they will see 'the light' for many years without dollar signs
attached.

A question worth asking is: Who needs whom?  Do we (FLOSS community)
need them (Graphics hardware manufactures) or do they need us?
Despite growth in Linux on Desktops, I think we need them a lot more
than they need us.

There is no question that making drives for these card that work
nicely with Linux and xorg will take some substantial effort.  And it
isn't work that can be easily spread around the community due to
various trade secret issues.  This suggests, to me at least, that the
work needs to be done by a fairly small group of people who can sign
NDAs with NVidia or ATI and work with their engineers and with the
community to develop the right interfaces and to make drivers that
have a minimal closed-source component that lives in user-space.

Who is going to pay these people to do this work?  If you agree with
the analysis of 'who needs whom', the logical answer is 'us'.

Maybe we need a small consortium of companies with vested interest in
OSS each ponying up half a million, and use this to employ two teams
of graphics experts, one of which works within NVidia, and one within
ATI.  I suspect the two companies could be convinced to take on some
free engineering support, if it was presented the right way.

Anyone got a few dollars to spare?

NeilBrown
