Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSHHQga>; Thu, 8 Aug 2002 12:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSHHQga>; Thu, 8 Aug 2002 12:36:30 -0400
Received: from ns1.weccusa.org ([207.1.28.170]:49145 "EHLO trabajo")
	by vger.kernel.org with ESMTP id <S317639AbSHHQg3>;
	Thu, 8 Aug 2002 12:36:29 -0400
Date: Thu, 8 Aug 2002 11:39:52 -0500
From: "Bryan K. Walton" <thisisnotmyid@tds.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with 1gb ddr memory sticks on linux
Message-ID: <20020808163952.GJ16225@weccusa.org>
References: <20020808160456.GI16225@weccusa.org> <1028828840.28883.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028828840.28883.43.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 06:47:20PM +0100, Alan Cox wrote:
> 
> Almost certainly a BIOS problem. What typically happens when you see
> this is that the BIOS misconfigured the MTRR registers. Linux starts
> from top of ram windows seems to start from bottom so the effect shows
> strongly in Linux.
> 
> Can you post your /proc/mtrr file please
> 
Here you go . . .

Dimm slot 1 = 256MB DDR PC2100 and
Dimm slot 2 = 1024MB DDR PC2100

and the /proc/mtrr shows:

casa:~# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1 

Thanks,
Bryan
