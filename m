Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTFLMWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTFLMWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:22:36 -0400
Received: from inconnu.isu.edu ([134.50.8.55]:45725 "EHLO inconnu.isu.edu")
	by vger.kernel.org with ESMTP id S264638AbTFLMWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:22:35 -0400
Date: Thu, 12 Jun 2003 06:36:14 -0600 (MDT)
From: I Am Falling I Am Fading <skuld@anime.net>
X-X-Sender: skuld@inconnu.isu.edu
To: Dave Jones <davej@codemonkey.org.uk>
cc: John Bradford <john@grabjohn.com>, <gregor.essers@web.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Via KT400 and AGP 8x Support
In-Reply-To: <20030612123056.GA6912@suse.de>
Message-ID: <Pine.LNX.4.44.0306120633490.14263-100000@inconnu.isu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, Dave Jones wrote:

>  > Tried it already... The pins are too small to get adequate purchase for 
>  > the tape -- the friction just causes it to slide around in the slot and 
>  > gets goo around.
>  > 
>  > Superglue might be a better solution....
>  > ...but I think the solder method is better.
> 
> So rather than experiment with backporting the 2.5 code to 2.4,
> you'd rather risk damaging your hardware ?
> 
> I think this way is madness.

Unfortunately even a perfect backport seems to be only a partial solution 
-- the ATI binary only drivers don't seem to know how to talk to the 2.5 
AGP 3.0 stuff anyway (well, at least they didn't work at all when I tried 
them under the 2.5 kernel :-/), and as they are lame binary-only drivers 
there is no way to fix that. 

There are also no other drivers for the R300-series Radeon GPUs. :-(

This absolutely sucks, but turning the card into an AGP 2.0 card seems to 
be the only surefire way to get it to work properly under Linux. :-(

-----
James Sellman -- ISU CoE-CS/ISLUG Linux Lab Admin   |"Lum, did you just see
----------------------------------------------------| a hentai rabbit flying
skuld@inconnu.isu.edu      |   // A4000/604e/60 128M| through the air?"
skuld@anime.net            | \X/  A500/20 3M        |   - Miyake Shinobu

