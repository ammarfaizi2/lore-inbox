Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136738AbREHCtE>; Mon, 7 May 2001 22:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136739AbREHCsy>; Mon, 7 May 2001 22:48:54 -0400
Received: from funnelweb.dascom.com.au ([203.144.16.133]:7164 "EHLO
	mulga.surf.ap.tivoli.com") by vger.kernel.org with ESMTP
	id <S136738AbREHCsg>; Mon, 7 May 2001 22:48:36 -0400
Message-ID: <XFMail.20010508124825.peterw@dascom.com.au>
X-Mailer: XFMail 1.4.6 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <988925908.1280.42.camel@agate>
Date: Tue, 08 May 2001 12:48:25 +1000 (EST)
Reply-To: peterw@dascom.com.au
From: Peter Waltenberg <peterw@dascom.com.au>
To: linux-kernel@vger.kernel.org
Subject: RAID question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a RAID 5 system thats had 2 of 6 disks in the RAID go into thermal
shutdown. (Air-con failure).

The disks are functional, but the RAID won't restart because the superblock
timestamps on those two disks are now out of step with the rest of the array and
there aren't enough "good" disks to reconstruct the array.

We know there was very little activity when this happened.

Does anyone out there know of a way to hack the superblocks on the "bad" disks
to force them to appear to be O.K. so that the RAID will restart. 

Thanks
Peter 





