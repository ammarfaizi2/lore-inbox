Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSATUox>; Sun, 20 Jan 2002 15:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSATUom>; Sun, 20 Jan 2002 15:44:42 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:24077 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S285369AbSATUod>; Sun, 20 Jan 2002 15:44:33 -0500
Date: Sun, 20 Jan 2002 21:44:31 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Ville Herva <vherva@twilight.cs.hut.fi>
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020120214430.A4000@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ville Herva <vherva@niksula.cs.hut.fi>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net> <20020120152359.B326@localhost> <20020120200255.GG135220@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020120200255.GG135220@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sun, Jan 20, 2002 at 10:02:55PM +0200
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 10:02:55PM +0200, Ville Herva wrote:
> 
> Just out of interest (I'm not actually suggesting this would be useful, or
> feasible): what about ilink(dev, inode_nr, "path") or iopen(dev, inode_nr)?
> 
> Or /proc/inodes/dev/<nr> ?

...which would successfully defeat any access control scheme based on
directory permissions...

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
