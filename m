Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWBCQwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWBCQwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWBCQwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:52:17 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:49104 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751226AbWBCQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:52:17 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 17:50:41 +0100
To: luke@dashjr.org, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: 
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43E389E1.nail5CAVYV548@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <20060123212119.GI1820@merlin.emma.line.org>
 <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <200602021717.08100.luke@dashjr.org>
 <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >> >2. find out the current state of affairs,
> >>
> >> I am currently able to properly write all sorts of CD-R/RW and DVDÂ±R/RW,
> >> DVD-DL with no problems using
> >>     cdrecord -dev=/dev/hdb
> >> it _currently_ works, no matter how ugly or not this is from either JÃ¶rg's
> >> or any other developer's POV - therefore it's fine from the end-user's POV.
> >
> >How did you manage to burn a dual layer disc? I have been completely 
> >unsuccessful at doing this at all. :(
> >
>
> You have to add  -driver=mmc_dvdplusr , because the Dual Layer discs are 
> not yet in the ProDVD database as it seems.

They are if you use a halfway recent cdrecord.

> userwhat? You mean supplemental groups as printed by id(1)? I find them 
> ugly, because it's a real hassle to manage it with files.
>
> In the past, NGROUPS_MAX also was 32, being more of a limit than today.

If you extend NGROUPS_MAX to be more than 16, NFS AUTH_UNIX will not work 
anymore.

And BTW: using NGROUPS seems to be a bit outdated now, more than 10 years after
ACLs have been introduced on UNIX.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
