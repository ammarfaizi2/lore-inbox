Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbRCJC6E>; Fri, 9 Mar 2001 21:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbRCJC5y>; Fri, 9 Mar 2001 21:57:54 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:26884 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S130902AbRCJC5p>; Fri, 9 Mar 2001 21:57:45 -0500
Date: Fri, 9 Mar 2001 18:57:03 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18, Intel i815 chipset and DMA
Message-ID: <20010309185703.A24221@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010309090641.C13905@greenhydrant.com> <E14bQaA-0005Jc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14bQaA-0005Jc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 09, 2001 at 05:21:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 05:21:36PM +0000, Alan Cox wrote:
> > I've got a Gateway here with a Intel 815 chipset running 2.2.18.  Inside
> > it's a PIII 733 with 512MB and a Quantum lct15 drive.
> 
> The UDMA100 on the i810/815 is supported by 2.4
> 
> > turn it on?  The drive should be capable of 10-20MB/s, but I'm
> > only getting about 4MB/s with hdparm.  :-(
> 
> /dev/hda:
>  Timing buffered disk reads:  64 MB in  2.62 seconds = 24.43 MB/sec
> 
> [2.4.2ac17]

OK, I moved the machine to 2.4.2, hdparm is now reading 20MB/sec from
each disk as expected.

Thanks for the tips,
Dave
