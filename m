Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129223AbQJ3BjQ>; Sun, 29 Oct 2000 20:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQJ3BjH>; Sun, 29 Oct 2000 20:39:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44805 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129223AbQJ3Biz>; Sun, 29 Oct 2000 20:38:55 -0500
Date: Sun, 29 Oct 2000 18:35:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001029183531.A7155@vger.timpanogas.org>
In-Reply-To: <39FCB09E.93B657EC@timpanogas.org> <E13q2R7-0006S7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E13q2R7-0006S7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 30, 2000 at 12:04:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:04:23AM +0000, Alan Cox wrote:
> > It's still got some problems with NFS (I am seeing a few RPC timeout
> > errors) so I am backreving to 2.2.17 for the Ute-NWFS release next week,
> > but it's most impressive.
> 
> Can you send a summary of the NFS reports to nfs-devel@linux.kernel.org

Yes.  I just went home, so I am emailing from my house.  I'll post late 
tonight or in the morning.  Performance on 100Mbit with NFS going 
Linux->Linux is getting better throughput than IPX NetWare Client -> 
NetWare 5.x on the same network by @ 3%.  When you start loading up a 
Linux server, it drops off sharply and NetWare keeps scaling, however, 
this does indicate that the LAN code paths are equivalent relative to 
latency vs. MSM/TSM/HSM in NetWare.  NetWare does better caching 
(but we'll fix this in Linux next).  I think the ring transitions to 
user space daemons are what are causing the scaling problems 
Linux vs. NetWare.

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
