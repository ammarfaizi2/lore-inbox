Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRDCTKG>; Tue, 3 Apr 2001 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRDCTJ4>; Tue, 3 Apr 2001 15:09:56 -0400
Received: from cc946626-a.vron1.nj.home.com ([24.5.103.153]:7940 "EHLO
	tela.bklyn.org") by vger.kernel.org with ESMTP id <S132439AbRDCTJp>;
	Tue, 3 Apr 2001 15:09:45 -0400
Date: Tue, 3 Apr 2001 15:08:52 -0400
From: Caleb Epstein <cae@bklyn.org>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS client code slow in 2.4.3
Message-ID: <20010403150852.A1310@hagrid.bklyn.org>
Reply-To: Caleb Epstein <cae@bklyn.org>
In-Reply-To: <20010403145615.C1049@hagrid.bklyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403145615.C1049@hagrid.bklyn.org>; from cae@bklyn.org on Tue, Apr 03, 2001 at 02:56:15PM -0400
Organization: Brooklyn Dust Bunny Mfg.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 02:56:15PM -0400, Caleb Epstein wrote:

> 	I am having problems with timeouts and generaly throughput in
> the 2.4.3 NFS client side code which are not present in the 2.4.2
> kernel running in the same configuraiton on the same hardware.  The
> machines are on a 100 Mbit switched local network with essentially
> no other trafic.

	On second thought, it looks like 2.4.2 may also exhibit the
	same behaviro after a little while.  Now that the machine has
	been up for a half hour or so, NFS traffic has become slow on
	my 2.4.2 client again.  I am seeing messages like this in my
	kernel log:

Apr  3 15:01:54 hagrid kernel: nfs: server tela not responding, still trying
Apr  3 15:01:54 hagrid kernel: nfs: server tela OK

	The machines are *not* having any connectivity problems, at
	least judging from TCP sessions I have open between them.

	So it would seem that NFS performace degrades over a very
	short window in 2.4.2+.  It seems to fairly fly when the
	machine is freshly booted, but after 30 minutes or less, the
	performance is severely degraded.

	Is anyone using 2.4.2+ as a NFS server/client with success?
	Am I missing something?

-- 
cae at bklyn dot org | Caleb Epstein | bklyn . org | Brooklyn Dust Bunny Mfg.
