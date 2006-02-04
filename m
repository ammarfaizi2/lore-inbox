Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWBDPnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWBDPnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBDPnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:43:21 -0500
Received: from mail.gmx.net ([213.165.64.21]:14493 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932236AbWBDPnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:43:20 -0500
X-Authenticated: #428038
Date: Sat, 4 Feb 2006 16:43:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060204154314.GA18821@merlin.emma.line.org>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo> <20060203180421.GA57965@dspnet.fr.eu.org> <20060203183719.GB11241@voodoo> <m3u0bfdtm4.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u0bfdtm4.fsf@defiant.localdomain>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2006, Krzysztof Halasa wrote:

> And, if we are here, what's wrong with hald using O_EXCL to not
> interrupt any other program (does hald need to check the media
> if it's in use)? I assume the problem wouldn't exist with hald
> using O_EXCL and cdrecord not (yet) using it, would it?

Let me throw in a stupid question: Is O_EXCL cooperative, in that other
access is only blocked if both tasks use open(...O_EXCL...)?

-- 
Matthias Andree
