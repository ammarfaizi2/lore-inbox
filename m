Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTCTIdz>; Thu, 20 Mar 2003 03:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCTIdz>; Thu, 20 Mar 2003 03:33:55 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:64711 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261328AbTCTIdz>; Thu, 20 Mar 2003 03:33:55 -0500
Date: Thu, 20 Mar 2003 09:41:48 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: alan@lxorguk.ukuu.org.uk, KML <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH 2.5] PCI quirk for SMBus bridge on Asus P4 boards
Message-ID: <20030320084148.GA2414@brodo.de>
References: <20030319211837.GA23651@brodo.de> <1048146514.12350.43.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048146514.12350.43.camel@workshop.saharact.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 09:48:35AM +0200, Martin Schlemmer wrote:
> On Wed, 2003-03-19 at 23:18, Dominik Brodowski wrote:
> > Asus hides the SMBus PCI bridge within the ICH2 or ICH4 southbridge on
> > Asus P4B/P4PE mainboards. The attached patch adds a quirk to re-enable the
> > SMBus PCI bridge for P4B533 and P4PE mainboards.
> > 
> 
> The ASUS P4T533-C J(850E Chipset) does that as well .... think you might
> tweak the patch for this board ?  I can test if you can ....

Sure: please send me the output of "pcitweak -l" or "lspci -vv".

	Dominik
