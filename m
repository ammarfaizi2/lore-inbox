Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUBSKhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267177AbUBSKhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:37:17 -0500
Received: from ez246.neoplus.adsl.tpnet.pl ([83.30.7.246]:52102 "EHLO
	uran.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S267176AbUBSKhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:37:16 -0500
Date: Thu, 19 Feb 2004 11:36:56 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: Henrik Christian Grove <grove@sslug.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 compile error with FB_RADEON_I2C
Message-ID: <20040219103656.ALLYOURBASEAREBELONGTOUS.A14930@kolkowski.no-ip.org>
Mail-Followup-To: Henrik Christian Grove <grove@sslug.dk>,
	linux-kernel@vger.kernel.org
References: <7gbrnwnpq3.fsf@serena.fsr.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7gbrnwnpq3.fsf@serena.fsr.ku.dk>
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:damian@kolkowski.no-ip.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.25, up 17:30
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Henrik Christian Grove <grove@sslug.dk> [2004-02-18 23:55]:
> It looks like this might be caused by the fact that I have I2C support
> as a module, but support for the Radeon framebuffer in kernel. Wth
> FB_RADEON_I2C=y that probably shouldn't be a possible configuration.

Yep.., that is the problem, new radeonfb needs CONFIG_I2C i kernel.

-- 
# Damian *dEiMoS* Ko³kowski # http://kolkowski.no-ip.org/ #
