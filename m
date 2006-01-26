Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWAZVkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWAZVkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWAZVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:40:34 -0500
Received: from mail.gmx.net ([213.165.64.21]:26802 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751413AbWAZVke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:40:34 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 22:40:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126214029.GB26319@merlin.emma.line.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <20060125142155.GW4212@suse.de> <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr> <20060125145544.GA4212@suse.de> <43D7AEBF.nailDFJ7263OE@burner> <43D7B100.7040706@gmx.de> <43D7B345.nailDFJB1WWYF@burner> <20060125231957.GC2137@merlin.emma.line.org> <43D8C0E9.nailE1C31558S@burner> <20060126125825.GB14256@merlin.emma.line.org> <Pine.LNX.4.61.0601262146480.27891@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601262146480.27891@yvahk01.tjqt.qr>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am 2006-01-26:

> I think you (Matthias) get it slightly skewed here. As far as I am able to 
> slip through the flames, libscg is used by cdrecord just as libc is used by 
> all apps to have "some sort" of OS abstraction (pick some function, like 
> fork()). Therefore, libscg seems +not only+ about cd writing. However, if 
> you want to have a working cdrecord, you need a working libscg, just like 
> you need a working libc or your system is going bye-bye.

I couldn't care less if libscg works for ATAPI tapes. No-one provided
input for ATAPI tapes that do verify-while-write (call it read after
write if you want, Hinterbandkontrolle in German) yet, and potential
libscg-can't-get-a-hold-of-ATAPI-tapes problems can be discussed in a
separate thread if you don't mind.

-- 
Matthias Andree
