Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbRBVPzq>; Thu, 22 Feb 2001 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRBVPzg>; Thu, 22 Feb 2001 10:55:36 -0500
Received: from [63.95.87.168] ([63.95.87.168]:10509 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129741AbRBVPzZ>;
	Thu, 22 Feb 2001 10:55:25 -0500
Date: Thu, 22 Feb 2001 10:55:24 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via UDMA5 3/4/5 is not functional!
Message-ID: <20010222105524.C6505@xi.linuxpower.cx>
In-Reply-To: <LOEGIBFACGNBNCDJMJMOAEOACEAA.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <LOEGIBFACGNBNCDJMJMOAEOACEAA.gallir@uib.es>; from gallir@uib.es on Thu, Feb 22, 2001 at 04:38:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 04:38:48PM +0100, Ricardo Galli wrote:
> > Then I tried kernel 2.4.1. I issued exactly the same hdparm command.
> > i got in syslog the message: "ide0: Speed warnings UDMA 3/4/5 is not
> > functional"!
> I had the same problem.
> Add
> append="ide0=ata66 ide1=ata66 ide0=autotune ide1=autotune hda=autotune
> hdb=autotune hdc=autotune"
> to lilo.conf.
> 
> BTW, I am having now CRC errors in IDE1 on the VIA, IDE0 it's ok at udma5
> and 30MB/sec.

Are you not using a udma cable? :)
