Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWBBMYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWBBMYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWBBMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:24:14 -0500
Received: from mail.gmx.net ([213.165.64.21]:39362 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750949AbWBBMYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:24:13 -0500
X-Authenticated: #428038
Date: Thu, 2 Feb 2006 13:24:03 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202122403.GA15507@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1EA35.nail4R02QCGIW@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-02:

> Jim Crilly <jim@why.dont.jablowme.net> wrote:
> 
> > Every other method to access those devices uses the device name, i.e.
> > mount, fsck, etc, so why should cdrecord be different?
> 
> inadequateness on Linux did force libscg to go this way.
> 
> The current method used by libscg is well established since 10 years.
> 
> Now Linux likes to confuse people by trying to enforce a completely 
> incompatible access method.
> 
> Note that I need to avoid unneeded efforts and for this reason, I need to wait
> 5 years until is is forseable that a recent incompatible change in Linux will
> survive long enough to spent time on it.

It is incompatible? Looks like the code is already implemented and ATA:
is in the regular device name space (where RSCSI and the other options
reside as well).

-- 
Matthias Andree
