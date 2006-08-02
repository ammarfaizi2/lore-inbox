Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWHBURc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWHBURc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWHBURc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:17:32 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:8979 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932217AbWHBURb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:17:31 -0400
Date: Wed, 2 Aug 2006 21:17:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Mathias Adam <a2@adamis.de>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060802201723.GC7173@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Mathias Adam <a2@adamis.de>
References: <20060802194938.GL5972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802194938.GL5972@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 03:49:38PM -0400, Dave Jones wrote:
> This patch has been submitted a number of times, and doesn't seem
> to get any upstream traction, which is a shame, as it seems to work
> for users, and I keep inadvertantly dropping it from the Fedora
> kernel everytime I rebase it.

As I've said, I'm ignoring all 950 patches because I don't know what
works and what doesn't, and it's highly likely that applying one fix
for one card breaks already working fixes for other cards because
they have different crystals fitted, thereby requiring different
register settings.

My requests for the broken BT hardware which dwmw2 promised me which
the original requests were based upon have consistently resulted in
promise of action but no real action.

Basically, either I need 950 based hardware so I can at least validate
that new fixes don't break existing setups, or someone else needs to
be in this position and take on the responsibility for reviewing and
testing future 950 based patches.

I don't believe that there are sufficient users out there who follow
the kernel to allow the "dump in -mm and wait a bit to see if anyone
complains" solution will work.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
