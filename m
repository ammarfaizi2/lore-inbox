Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWC0QuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWC0QuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWC0QuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:50:17 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:60166 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751108AbWC0QuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:50:15 -0500
Date: Mon, 27 Mar 2006 11:48:49 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Sebastian <sebastian@expires0606.datenknoten.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@dominikbrodowski.net, Netdev List <netdev@vger.kernel.org>,
       proski@gnu.org
Subject: Re: [PATCH] pcmcia: avoid binding hostap_cs to Orinoco cards
Message-ID: <20060327164844.GF14403@tuxdriver.com>
Mail-Followup-To: Sebastian <sebastian@expires0606.datenknoten.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux@dominikbrodowski.net, Netdev List <netdev@vger.kernel.org>,
	proski@gnu.org
References: <200603012259.k21MxEN3013604@hera.kernel.org> <44063023.9010603@pobox.com> <1143459885.9691.6.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143459885.9691.6.camel@coruscant.datenknoten.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 01:44:44PM +0200, Sebastian wrote:
> > commit 40e3cad61197fce63853e778db020f7637d988f2
> > tree 6e086c930e1aef0bb24eb61af42d1f3c1fb7d38c
> > parent f0892b89e3c19c7d805825ca12511d26dcdf6415
> > author Pavel Roskin <proski@gnu.org> Tue, 28 Feb 2006 11:18:31 -0500
> > committer Dominik Brodowski <linux@dominikbrodowski.net> Wed, 01 Mar 
> > 2006 11:12:00 +0100
> > 
> > [PATCH] pcmcia: avoid binding hostap_cs to Orinoco cards
> > 
> > Don't just use cards with PCMCIA ID 0x0156, 0x0002.  Make sure that
> > the vendor string is "Intersil" or "INTERSIL"
> > 
> > Signed-off-by: Pavel Roskin <proski@gnu.org>
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > 
> >  drivers/net/wireless/hostap/hostap_cs.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletion(-)

> this patch seems to break my setup. The hostap_cs driver included in
> kernel 2.6.16 does not detect my Prism 2 WLAN card anymore, although it
> is *not* Orinoco. With 2.6.15.5 it still worked.

This patch didn't come through me, so I don't know much about it.
Hopefully Pavel or Dominik can comment?

John
-- 
John W. Linville
linville@tuxdriver.com
