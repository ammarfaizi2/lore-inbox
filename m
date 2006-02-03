Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWBCNvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWBCNvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWBCNvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:51:19 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52116 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750786AbWBCNvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:51:18 -0500
Date: Fri, 3 Feb 2006 14:51:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: rlrevell@joe-job.com, jim@why.dont.jablowme.net, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E35AC8.nail5CAD55WJ3@burner>
Message-ID: <Pine.LNX.4.61.0602031448270.7991@yvahk01.tjqt.qr>
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo>
 <1138915551.15691.123.camel@mindpipe> <43E35AC8.nail5CAD55WJ3@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The main point is not to poll to frequent (Solaris does once everz 3 seconds)
>and to use SCSI commands only that to not interrupt or disturb CD/DVD-writing.
>

I do not have any problems with resmgr/hal ATM (SUSE Linux 10.0). Although 
hal [seems to] probes more often than once/3sec, it did not interrupt any 
of my cd writing processes. Maybe that's already a feature of cdrecord*, I 
don't know.
(With an older drive (AOpen CRW1232), the whole IDE bus was even 
blocked when blanking, leaving no option but to wait.)


Jan Engelhardt
-- 
