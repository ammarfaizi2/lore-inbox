Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUBQV7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266639AbUBQV7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:59:33 -0500
Received: from ln33.neoplus.adsl.tpnet.pl ([83.30.25.33]:32906 "EHLO
	uran.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S266719AbUBQV6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:58:23 -0500
Date: Tue, 17 Feb 2004 22:57:38 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org,
       Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Subject: Re: Radeonfb problem
Message-ID: <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org>
Mail-Followup-To: Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org,
	Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de> <20040217203604.GA19110@dreamland.darkstar.lan> <20040217211120.ALLYOURBASEAREBELONGTOUS.A8392@kolkowski.no-ip.org> <20040217213441.GA22103@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040217213441.GA22103@dreamland.darkstar.lan>
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:damian@kolkowski.no-ip.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.25-rc3, up  8:27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kronos <kronos@kronoz.cjb.net> [2004-02-17 22:51]:
> > 2.6.3-rc4 with new radeonfb looks better, but in lilo.con append for radeonfb
> > wont work.
> 
> What do you mean? What are passing to the kernel?

For example:

append = "video=radeon:1024x768-32@100" works for 2.4.x
append = "video=radeonfb:1024x768-32@100 works for 2.6.x

but for new radeonfb _radeonfb_ in append won't work, my screean start with
small res on 36 Hz ;-) So I need to use fbset.

Besides don't use 2.6.x even on desktop, that was only a test with new
radeonfb from Ben H.

-- 
# Damian *dEiMoS* Ko³kowski # http://kolkowski.no-ip.org/ #
