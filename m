Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317968AbSGPUKA>; Tue, 16 Jul 2002 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317971AbSGPUJ7>; Tue, 16 Jul 2002 16:09:59 -0400
Received: from p508875D5.dip.t-dialin.net ([80.136.117.213]:17811 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317968AbSGPUJ7>; Tue, 16 Jul 2002 16:09:59 -0400
Date: Tue, 16 Jul 2002 14:11:20 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Stelian Pop <stelian.pop@fr.alcove.com>, Sam Vilain <sam@vilain.net>,
       <dax@gurulabs.com>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020716193831.GC22053@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm>
X-Location: Calgary; CA
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, Matthias Andree wrote:
> > or the blockdevice-level snapshots already implemented in Linux..
> 
> That would require three atomic steps:
> 
> 1. mount read-only, flushing all pending updates
> 2. take snapshot
> 3. mount read-write
> 
> and then backup the snapshot. A snapshots of a live file system won't
> do, it can be as inconsistent as it desires -- if your corrupt target is
> moving or not, dumping it is not of much use.

Well, couldn't we just kindof lock the file system so that while backing 
up no writes get through to the real filesystem? This will possibly 
require a lot of memory (or another space to write to), but it might be 
done?

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

