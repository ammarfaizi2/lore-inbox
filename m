Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292752AbSCSVXc>; Tue, 19 Mar 2002 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292852AbSCSVXW>; Tue, 19 Mar 2002 16:23:22 -0500
Received: from zamok.crans.org ([138.231.136.6]:34503 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S292752AbSCSVXK>;
	Tue, 19 Mar 2002 16:23:10 -0500
To: Jaanus Toomsalu <jaanus@amd.matti.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HighPoint HPT372/374 full support?
In-Reply-To: <20020318140848.C9EEB25717@amd.matti.ee>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
Organization: Kabale Inc
Date: Tue, 19 Mar 2002 22:23:06 +0100
Message-ID: <m3u1rcuu9x.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO En ce début d'après-midi ensoleillé du lundi 18 mars 2002, vers
15:08, Jaanus Toomsalu <jaanus@amd.matti.ee> disait:

> Is there any hints to get this UDMA133 chip to work. Currently it seems to 
> reported work over WIP (WorkInProgress), but on my onboard ABIT KR7A-RAID i 
> get DMA disabled message and all hardisks on HPT372 IDE channel are "lost" 
> after that.

I have the same problem here, but just when I try to use md to setup a
disk array. In fact, I can dd to /dev/null two disks at the same time
(each on its separate controller) without any troubles (each disk
through output is 40 MB/s). Software raid with hptraid works fine but
I don't get significant performance improvement. But each time I try
to use md, I always get the same problem than you. mkraid, raidstop or
anything which access /dev/md0 triggers a DMA problem.

I have asked the question in linux-raid mailing list yesterday but got
no solution so far.

I have upgraded to newest BIOS patched with the latest BIOS from
Highpoint (2.31) and there is no change (but I think the BIOS is not
used). I have tried with a vanilla 2.4.18 and with 2.4.19-pre3-ac1.
-- 
I NO LONGER WANT MY MTV
I NO LONGER WANT MY MTV
I NO LONGER WANT MY MTV
-+- Bart Simpson on chalkboard in episode 3G02
