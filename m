Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRHMKip>; Mon, 13 Aug 2001 06:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRHMKif>; Mon, 13 Aug 2001 06:38:35 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:41785 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S270073AbRHMKiZ>; Mon, 13 Aug 2001 06:38:25 -0400
Date: Mon, 13 Aug 2001 12:38:28 +0200
From: Cliff Albert <cliff@oisec.net>
To: Jarno Paananen <jpaana@s2.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "scsi0:0:6:0: Attempting to queue an ABORT message" and friends hang
Message-ID: <20010813123828.A6676@oisec.net>
In-Reply-To: <m3d762c4sw.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d762c4sw.fsf@kalahari.s2.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 06:53:19AM +0300, Jarno Paananen wrote:

> I've lately come across these messages a bit too many times:
> 
> scsi0:0:6:0: Attempting to queue an ABORT message
> scsi0:0:6:0: Cmd aborted from QINFIFO
> aic7xxx_abort returns 8194
> scsi0:0:6:0: Attempting to queue an ABORT message
> scsi0:0:6:0: Cmd aborted from QINFIFO
> aic7xxx_abort returns 8194
> 
> [repeat ad infinitum]
> 
> and then all disk activity hangs. Is this a bug in the driver or a
> symptom from failing disks/cable or something? It happens on both
> my disks (sometimes the 0:6:0 is 0:5:0) so I hope it isn't the
> disks. I'm running 2.4.8-ac1 now, but it has come up every now and
> then since 2.4.6 kernels at least.

My Adaptec 7890 onboard of my P2B-S experienced the same problems.
However since i'm running 2.4.7-ac9 and up i have not experienced
any problem.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
