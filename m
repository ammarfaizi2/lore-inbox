Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWHTTQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWHTTQz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWHTTQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:16:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751158AbWHTTQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:16:54 -0400
Date: Sun, 20 Aug 2006 15:16:43 -0400
From: Dave Jones <davej@redhat.com>
To: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, linux-kernel@vger.kernel.org,
       drzeus-sdhci@drzeus.cx
Subject: Re: [Patch] Signedness issue in drivers/net/phy/phy_device.c
Message-ID: <20060820191643.GA2608@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>,
	Richard Knutsson <ricknu-0@student.ltu.se>,
	linux-kernel@vger.kernel.org, drzeus-sdhci@drzeus.cx
References: <1156008815.18192.3.camel@alice> <44E7E112.3010500@student.ltu.se> <20060820183600.GA3431@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820183600.GA3431@alice>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 08:36:00PM +0200, Eric Sesterhenn / Snakebyte wrote:
 > * Richard Knutsson (ricknu-0@student.ltu.se) wrote:
 > > Eric Sesterhenn wrote:
 > hi,
 > 
 > > Would it not be preferable to use a 's32' instead of an 'int'? After 
 > > all, it seem 'val' needs to be 32 bits.
 > 
 > not sure, but wouldnt this collide with platforms where an int is 64
 > Bits?

None of the 64-bit Linux ports use ILP64.

		Dave

-- 
http://www.codemonkey.org.uk
