Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131441AbRA3RXg>; Tue, 30 Jan 2001 12:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131409AbRA3RXP>; Tue, 30 Jan 2001 12:23:15 -0500
Received: from mean.netppl.fi ([195.242.208.16]:1806 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S130346AbRA3RXF>;
	Tue, 30 Jan 2001 12:23:05 -0500
Date: Tue, 30 Jan 2001 19:22:48 +0200
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Todd <todd@unm.edu>, linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
Message-ID: <20010130192248.A3684@netppl.fi>
In-Reply-To: <20010129164953.A15219@vger.timpanogas.org> <Pine.A41.4.31.0101292123270.54650-100000@aix06.unm.edu> <20010130101958.A18047@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010130101958.A18047@vger.timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 10:19:58AM -0700, Jeff V. Merkey wrote:
> On Mon, Jan 29, 2001 at 09:41:21PM -0700, Todd wrote:
> 
> Sparc servers.  The adapters these drivers I posted support are a bi-CMOS 
> implementation of the SCI LC3 chipsets, and even though they are 
> bi-CMOS, the Link speed on the back end is still 500 MB/S --
> very respectable.
Sounds impressive (and expensive)
> 
> in another system with **NO COPYING**.  Ethernet and LAN networking always 
> copies data into userspace -- SCI has the ability to dump it directly 
> into user space pages without copying.  That's what is cool about SCI, 
Well, my GigE card does that too. Not with TCP, though :)
(see http://oss.sgi.com/projects/stp)
> processor utilitzation will be high, and there will be lots of 
> copying going on in the system.   What numbers does G-Enet provide 
> doing userspace -> userspace transfers, and at what processor 
> overhead?  These are the types of things that are the metrics for 
What I get is 102MB/s with 4% CPU use on a dual pIII/500 32/66 box sending to
a dual pII/450 32/33 box (about 10M/s less the other way around, so 
I'm assuming I'd get somewhat more with real 64/66 PCI buses on both 
machines) 

> I could ask Dolphin for a GaAs version of the LC3 card (one board would
> cost the equivalent to the income of a small third world nation), and 
> rerun the tests on a Sparc system or Sequent system, and watch G-Enet
> system suck wind in comparison.  
Or you can buy an Alteon-based Netgear 620 for under $300. It all 
depends on your budget and needs :)

-- 
Pekka Pietikainen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
