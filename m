Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285398AbRLGEMl>; Thu, 6 Dec 2001 23:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285399AbRLGEMb>; Thu, 6 Dec 2001 23:12:31 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:62478 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S285398AbRLGEMZ>; Thu, 6 Dec 2001 23:12:25 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Thu, 6 Dec 2001 23:12:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: TCP performance eepro100
Message-ID: <20011206231225.A32585@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <054401c17ed2$3b03a0d0$0f00a8c0@minniemouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <054401c17ed2$3b03a0d0$0f00a8c0@minniemouse>; from marsaro@interearth.com on Thu, Dec 06, 2001 at 07:49:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001, Jon wrote:
> Has anyone done testing on eepro100 and seen really poor performance? I am
> seeing that the eepro100 in SuSE 2.4.7 and above is 50% slower than than
> 2.4.2 in RH 7.1 I am doing a simple test with ttcp against another RH server
> and then SuSE vs SuSE or vs the RH system. In all cases the eepro100at best
> shows 39mbs. In modules.conf I am setting options="0x30" that forces 100mbps
> Full Duplex, this is also reflected in dmesg. With the new intel e100 it is
> possible to get 60mbps on SuSE. Is there something in the Kernel build or
> Driver build that is multi-casting or filtering that may cause this? Any
> ideas at this point would help. BTW, I am using SMP Kernels on all the
> systems.

Jon,

No great thoughts other than to report that I did netpipe-tcp (from
Debian woody) testing of my eepro100's using a custom SMP 2.4.9
kernel, and easily saw 90 megabits per second.  Sorry I couldn't help
more.

Take care,
Daniel

> Regards,
> 
> Jon
> 

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
