Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312680AbSDAWpt>; Mon, 1 Apr 2002 17:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSDAWp3>; Mon, 1 Apr 2002 17:45:29 -0500
Received: from [194.106.46.201] ([194.106.46.201]:43075 "EHLO
	asus.verdurin.priv") by vger.kernel.org with ESMTP
	id <S312680AbSDAWp1>; Mon, 1 Apr 2002 17:45:27 -0500
Date: Mon, 1 Apr 2002 23:45:14 +0100
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in emu10k1 driver
Message-ID: <20020401224514.GC2718@asus.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020401215107.GA28180@asus.verdurin.priv> <E16sAU4-0000gd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Apr 2002, Alan Cox wrote:

> > VMware died when I put an audio CD into my DVD drive.  I wouldn't have
> > mentioned it here but for the fact that there was an Oops and when
> > decoded it pointed to the emu10k1 driver:
> 
> Yes but we don't know what vmware has been doing. Please try the same thing
> a few times without vmware running
> 
> > kernel BUG at audio.c:1474!
> > invalid operand: 0000
> 
> 
> This one does look like a real bug in the emu10k driver, rather than a
> vmware caused funny

Haven't been able to reproduce it with the VMware modules removed.
