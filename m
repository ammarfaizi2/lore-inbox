Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRH1AXN>; Mon, 27 Aug 2001 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRH1AXD>; Mon, 27 Aug 2001 20:23:03 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:44049 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S269967AbRH1AWy>; Mon, 27 Aug 2001 20:22:54 -0400
Date: Tue, 28 Aug 2001 01:23:09 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: VM: Bad swap entry 0044cb00
Message-ID: <20010828012308.A36433@compsoc.man.ac.uk>
In-Reply-To: <Pine.NEB.4.33.0108280204430.13898-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.4.21.0108271946300.7385-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108271946300.7385-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 07:46:56PM -0300, Marcelo Tosatti wrote:

> > I upgraded my kernel from 2.4.8ac10 to 2.4.9ac2 some hours ago and I found
> > the following message in my syslog file (I've never seen something like
> > this before):
> > 
> > Aug 27 22:40:46 r063144 kernel: VM: Bad swap entry 0044cb00
> > 
> > 
> > What does this mean (my machine seems to run fine)?
> 
> Did you turned any swap file/partition off? (with swapoff) 

fwiw, this seems to be a common characteristic of hardware problems with
2.4 kernels. I've had bad RAM (discovered by memtest86) which was producing
this error without any swapoff. Once it only occurred after an entire night
of kernel compiles (memtest86 found it easily however)

regards
john

-- 
"Premature generalization is the root of all evil."
	- Karl Fogel
