Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422924AbWBIRgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbWBIRgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422922AbWBIRgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:36:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45469 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1422924AbWBIRgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:36:44 -0500
Date: Thu, 9 Feb 2006 18:36:43 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060209.173519.1949.atrey@ucw.cz>
References: <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EB7BBA.nailIFG412CGY@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is why the mapping engine is in the Linux adoption part of
> libscg. It maps the non-stable device <-> /dev/sg* relation to a
> stable b,t,l address.

Nonsense. The b,t,l addresses are NOT stable (at least for transports
where the kernel would have to make them up) unless you take an extra
effort to make them stable (like I understand Solaris does). But you
can use the same extra effort to make the /dev entries stable (like
udev does).

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
COBOL -- Compiles Only Because Of Luck
