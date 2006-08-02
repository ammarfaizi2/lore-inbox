Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWHBUb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWHBUb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWHBUb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:31:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750846AbWHBUb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:31:56 -0400
Date: Wed, 2 Aug 2006 16:31:46 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Mathias Adam <a2@adamis.de>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060802203146.GB23389@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Mathias Adam <a2@adamis.de>
References: <20060802194938.GL5972@redhat.com> <20060802201723.GC7173@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802201723.GC7173@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 09:17:23PM +0100, Russell King wrote:
 > On Wed, Aug 02, 2006 at 03:49:38PM -0400, Dave Jones wrote:
 > > This patch has been submitted a number of times, and doesn't seem
 > > to get any upstream traction, which is a shame, as it seems to work
 > > for users, and I keep inadvertantly dropping it from the Fedora
 > > kernel everytime I rebase it.
 > 
 > As I've said, I'm ignoring all 950 patches because I don't know what
 > works and what doesn't

Well, thanks for the reply.

 > , and it's highly likely that applying one fix
 > for one card breaks already working fixes for other cards because
 > they have different crystals fitted, thereby requiring different
 > register settings.

FWIW, we've had that patch in Fedora (most of the time), since 2.6.13,
and I don't recall seeing any other serial breakage ports (on this,
or any UART for that matter).

 > My requests for the broken BT hardware which dwmw2 promised me which
 > the original requests were based upon have consistently resulted in
 > promise of action but no real action.
 > 
 > Basically, either I need 950 based hardware so I can at least validate
 > that new fixes don't break existing setups, or someone else needs to
 > be in this position and take on the responsibility for reviewing and
 > testing future 950 based patches.
 > 
 > I don't believe that there are sufficient users out there who follow
 > the kernel to allow the "dump in -mm and wait a bit to see if anyone
 > complains" solution will work.

Still, leaving a patch out in the cold for 11 months, when we know it
at least makes things work for some users strikes me as wrong.
If we took this approach with every driver, we'd end up not supporting
the majority of things we support today.

		Dave

-- 
http://www.codemonkey.org.uk
