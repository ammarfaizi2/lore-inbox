Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbTEKTnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTEKTnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:43:08 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:14812 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261175AbTEKTnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:43:07 -0400
Date: Sun, 11 May 2003 20:55:43 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: davidm@hpl.hp.com
Cc: Michel D?nzer <michel@daenzer.net>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-ID: <20030511195543.GA15528@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, davidm@hpl.hp.com,
	Michel D?nzer <michel@daenzer.net>, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com> <1052653415.12338.159.camel@thor> <16062.37308.611438.5934@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16062.37308.611438.5934@napali.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 11:09:00AM -0700, David Mosberger wrote:
 >   Michel> but there'd have to be fallbacks for older kernels (this is
 >   Michel> against 2.4.20-ben8):
 > 
 > OK, we have a chicken & egg problem then: I could obviously add Linux
 > kernel version checks where needed, but to do that, the patch first
 > needs to go into the kernel.  Dave, would you mind applying the patch
 > to your tree?  Then once Linus picked it up, I can send a new patch to
 > dri-devel.  Or does someone have a better suggestion?

With Linus doing the DRI sync-ups himself, maybe just pushing it his
way directly would work..  I'll roll it into the next 2.5-dj for some extra
testing, but I'm not going to be the one who pushes that linuswards
unless I get asked by the DRI folks.

		Dave

