Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317948AbSGPTfp>; Tue, 16 Jul 2002 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSGPTfo>; Tue, 16 Jul 2002 15:35:44 -0400
Received: from p508875D5.dip.t-dialin.net ([80.136.117.213]:659 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317948AbSGPTfn>; Tue, 16 Jul 2002 15:35:43 -0400
Date: Tue, 16 Jul 2002 13:38:27 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020716192651.GA22053@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0207161337170.3452-100000@hawkeye.luckynet.adm>
X-Location: Calgary; CA
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, Matthias Andree wrote:
> Indeed, but OTOH, what error is close to report when the file is opened
> read-only?

Well, you can still get EIO, EINTR, EBADF. Whatever you say, disregarding 
the close return code is never any good.

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

