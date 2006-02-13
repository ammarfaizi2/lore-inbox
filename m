Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWBMKy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWBMKy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWBMKy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:54:57 -0500
Received: from mail.gmx.net ([213.165.64.21]:9128 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932194AbWBMKy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:54:56 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 11:54:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213105452.GA32674@merlin.emma.line.org>
Reply-To: matthias.andree@gmx.de
Mail-Followup-To: matthias.andree@gmx.de
References: <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <43F05C0B.nailKUS2493B9@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F05C0B.nailKUS2493B9@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> I did say that stat->st_dev needs to be stable

Yeah right. And Earth turns into a tetrahedron at your command.
Dream on... but keep it for yourself.

And to shut this subthread for good, I searched the whole IEEE Std
1003.1, 2004 Edition - nothing states any stability for st_dev.

All you get with this standards are two uniqueness guarantees (i. e. no
duplicates at a certain point in time -- this does not imply any kind of
stability), namely:

1. st_dev changes across mounts (definitions) and

2. (st_dev,st_ino) tuples are unique (<sys/stat.h>)

Ready-made query:
<http://www.opengroup.org/cgi-bin/susv3search.pl?KEYWORDS=st_dev&CONTEXT=>

Please don't respond. You're wasting time.

-- 
Matthias Andree
