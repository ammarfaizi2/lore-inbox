Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285096AbRL0Anb>; Wed, 26 Dec 2001 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285098AbRL0AnV>; Wed, 26 Dec 2001 19:43:21 -0500
Received: from khazad-dum.debian.net ([200.196.10.6]:24448 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S285096AbRL0AnK>; Wed, 26 Dec 2001 19:43:10 -0500
Date: Wed, 26 Dec 2001 22:43:07 -0200
From: Henrique de Moraes Holschuh <hmh@rcm.org.br>
To: linux-kernel@vger.kernel.org
Subject: Re: PDC20265 ide_dma_timeout and RAID5 issues (2.4.17)
Message-ID: <20011226224307.B1837@khazad-dum>
In-Reply-To: <20011226120617.A1316@khazad-dum> <20011226121859.B1700@khazad-dum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011226121859.B1700@khazad-dum>; from hmh@rcm.org.br on Wed, Dec 26, 2001 at 12:18:59PM -0200
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, following a hint by Carlos Carvalho (thanks, man!), I downloaded and
applied the newest version of the IDE patches, and so far the system appears
to be working fine. I am stress-testing it, and will report back if it
breaks.

Apparently, there is a showstopper bug for the PDC20265 on a A7V for RAID in
the current IDE subsystem of 2.4.17, which is fixed in the newest
incarnation of the IDE patches.  So, for archival purposes, anyone having
issues and hangs with Promise PDC20265 controllers and Linux Software
RAID5, on a VIA kt133 board... you may need to update the IDE subsystem with
the newest patches from linuxdiskcert.org to solve your problem.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
