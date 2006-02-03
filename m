Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWBCQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWBCQsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWBCQsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:48:45 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:22221 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751210AbWBCQso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:48:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 17:47:23 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: rlrevell@joe-job.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E3891B.nail5CATADRET@burner>
References: <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo> <1138915551.15691.123.camel@mindpipe>
 <43E35AC8.nail5CAD55WJ3@burner>
 <Pine.LNX.4.61.0602031448270.7991@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602031448270.7991@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >
> >The main point is not to poll to frequent (Solaris does once everz 3 seconds)
> >and to use SCSI commands only that to not interrupt or disturb CD/DVD-writing.
> >
>
> I do not have any problems with resmgr/hal ATM (SUSE Linux 10.0). Although 
> hal [seems to] probes more often than once/3sec, it did not interrupt any 
> of my cd writing processes. Maybe that's already a feature of cdrecord*, I 
> don't know.
> (With an older drive (AOpen CRW1232), the whole IDE bus was even 
> blocked when blanking, leaving no option but to wait.)

If you like to investigate on this, you would need to e.g. use cdrecord to 
write a DVD on a Pioneer DVD writer of check a notebook with only one ATA cable 
for both HDD and DVD-writer.

The fact that it does work for you does not prove that there is no problem.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
