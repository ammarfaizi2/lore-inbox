Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSGPWak>; Tue, 16 Jul 2002 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSGPWaj>; Tue, 16 Jul 2002 18:30:39 -0400
Received: from pD952AE51.dip.t-dialin.net ([217.82.174.81]:18324 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318151AbSGPWai>; Tue, 16 Jul 2002 18:30:38 -0400
Date: Tue, 16 Jul 2002 16:33:18 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: stoffel@lucent.com
cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <15668.39927.923118.516621@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0207161630220.3452-100000@hawkeye.luckynet.adm>
X-Location: Calgary; CA
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I do it like this:

-> Reconfigure port switch to use B server
-> Backup A server
-> Replay B server journals on A server
-> Switch to A server
-> Backup B server
-> Replay A server journals on B server
-> Reconfigure port switch to dynamic mode

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

