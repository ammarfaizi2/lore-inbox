Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTFKIOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 04:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFKIOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 04:14:45 -0400
Received: from inconnu.isu.edu ([134.50.8.55]:52096 "EHLO inconnu.isu.edu")
	by vger.kernel.org with ESMTP id S264226AbTFKIOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 04:14:44 -0400
Date: Wed, 11 Jun 2003 02:28:24 -0600 (MDT)
From: I Am Falling I Am Fading <skuld@anime.net>
X-X-Sender: skuld@inconnu.isu.edu
To: linux-kernel@vger.kernel.org
cc: gregor.essers@web.de
Subject: Re: Via KT400 and AGP 8x Support
Message-ID: <Pine.LNX.4.53.0306110210220.27802@inconnu.isu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In wich Kerneltree will this implented ?
> 2.4.x or 2.5.x ?
>
> Ati-Drivers will not install or Run on 2.5.70 (its clear ;) )
> and 2.4.20 and 2.4.21-pre7

I've had this problem as well.

What I've been able to do is to use a backport for one of the 2.4.21-pre*
series, and move the code forward to the current 2.4.21-rc's .

Here's info on the relevant patch:

http://lists.insecure.org/lists/linux-kernel/2003/Mar/3999.html

The Radeon 9700 Pro now functions with the ATI binary-only drivers, BUT
only with 2D acceleration. In other words, I have to set the "DisableDRI"
option in XF86Config-4 to yes.

So I get no 3D acceleration, but at least I get 2D acceleration and don't
have to run it in framebuffer mode like before.

I wish ATI would either open-source their drivers or come out with a fix
ASAP. :-/

-----
James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just see
----------------------------------------------------| a hentai rabbit flying
skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu
