Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTFKWFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTFKWFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:05:55 -0400
Received: from harddata.com ([216.123.194.198]:39586 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S264531AbTFKWFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:05:46 -0400
Date: Wed, 11 Jun 2003 16:19:02 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: mru@users.sourceforge.net, Rene Engelhard <rene@rene-engelhard.de>,
       Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org
Subject: Re: Compatible Hardware (Was: Re: RealTek NIC on alpha?)
Message-ID: <20030611161902.A12972@mail.harddata.com>
References: <20030611091910.GD801@rene-engelhard.de> <wrpznkp9d69.fsf@hina.wild-wind.fr.eu.org> <yw1x4r2wu7vk.fsf@zaphod.guide> <20030611164200.55f399d2.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611164200.55f399d2.gigerstyle@gmx.ch>; from gigerstyle@gmx.ch on Wed, Jun 11, 2003 at 04:42:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 04:42:00PM +0200, Marc Giger wrote:
> Hi All,
> 
> Since a long time I asking me, which PC-Hardware is compatible
> with Alpha's? All? Is it just a question if the driver exists for
> this architecture?

Mostly.

> So as example I could take an ATI Radeon or an Adaptec 29160 SCSI
> Controller, put it into an Alpha and it works?

If you want to boot from a disk attached to this controller then
this is a question if your firmware will recognize it as you will
have to load some things from it.  If this is not your boot device
then the answer should be yes.

Graphics card is slightly different problem as they have to be
usually initialized by an x86 BIOS emulator embedded in your
firmware and this may, or may not, work depending on your video
card.  I heard about cards which worked once X started but would
give nothing on a console.  I do not remember now specifics of
configuration.  In practice newer video cards were becoming on
Alpha more and more of an issue.

ATI Radeon 7500 AGP works fine in UP1500 (Nautilus with an AGP
slot) provided you have a correct X server support for it.  I know
because I have one on my desk. :-)

  Michal
