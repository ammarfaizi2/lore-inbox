Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131033AbRA3RNf>; Tue, 30 Jan 2001 12:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131096AbRA3RNZ>; Tue, 30 Jan 2001 12:13:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:38925 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131033AbRA3RNL>; Tue, 30 Jan 2001 12:13:11 -0500
Date: Tue, 30 Jan 2001 11:07:55 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Todd <todd@unm.edu>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
Message-ID: <20010130110755.A18554@vger.timpanogas.org>
In-Reply-To: <20010130101958.A18047@vger.timpanogas.org> <Pine.A41.4.31.0101301004290.37454-100000@aix01.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.A41.4.31.0101301004290.37454-100000@aix01.unm.edu>; from todd@unm.edu on Tue, Jan 30, 2001 at 10:07:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 10:07:07AM -0700, Todd wrote:
> folx,
> 
> On Tue, 30 Jan 2001, Jeff V. Merkey wrote:
> > What numbers does G-Enet provide
> > doing userspace -> userspace transfers, and at what processor
> > overhead?
> 
> using stock 2.4 kernel and alteon acenic cards with stock firmware we're
> seeing 993 MBps userspace->userspace (running netperf UDP_STREAM tests,
> which run as userspace client and server) with 88% CPU utilization.
> 
> Using a modified version of the firmware that we wrote we're getting
> 993Mbps with 55% CPU utilization.

I was at 2% utilization running the PCI-SCI tests on a D320 PSB64 adapter.
I doubt you would get good numbers on the box I used with G-Enet -- this 
box is limited to 70 MB/S PCI throughput.  

> 
> > I posted the **ACCURATE** numbers from my test, but I did clarify that I
> > was using a system with a limp PCI bus.
> >
> > Jeff
> 
> i appreciate that.  i'm just trying to figure out why the numbers are so
> low compared to the network speed you mentioned.

Because I used an el-cheapo AMD box.  I provided the info more for a 
2.2.X/2.4.X comparison than anything.  

Jeff

> 
> todd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
