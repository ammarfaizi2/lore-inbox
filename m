Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271920AbRIDJfV>; Tue, 4 Sep 2001 05:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271924AbRIDJfM>; Tue, 4 Sep 2001 05:35:12 -0400
Received: from techmonkeys.org ([24.72.12.135]:34178 "EHLO techmonkeys.org")
	by vger.kernel.org with ESMTP id <S271920AbRIDJfB>;
	Tue, 4 Sep 2001 05:35:01 -0400
Date: Tue, 4 Sep 2001 03:35:17 -0600
From: "Matthew S . Hallacy" <poptix@techmonkeys.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
Message-ID: <20010904033517.G20505@techmonkeys.org>
In-Reply-To: <E15dorf-0003vE-00@pranika.wulf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15dorf-0003vE-00@pranika.wulf>; from ejolson%pranika@fractal.math.unr.edu on Mon, Sep 03, 2001 at 01:13:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 01:13:51AM -0700, Eric Olson wrote:
> I have found these Athlon problems are very interesting.
> 
> Is there a usermode memory testing program which uses the K7 MMX 3DNow
> streaming cache bypass load/store instruction sequences that appear in
> linux/arch/i386/lib/mmx.c ?
> 
> Could Robert Redelmeier's burnMMX at 
> 	http://users.ev1.net/~redelm/
> be modified for the Athlon to detect these problems?
> 

Howdy, I've got a 1.3Ghz (non overclocked) running on the SiS 735 chipset
(yes, the first good chipset from SiS) with no problems under 2.4.9 with
athlon optimizations, the system has DDR ram, and is used a lot for video
capture/compression, the avifile library detects (and supposedly uses) the
optimizations, and I've had no problems whatsoever with the system. Perhaps
this is another VIA problem.

> It would be usefull to have a Microsoft Windows program that could 
> detect a faulty system without having to load Linux.  This would allow 
> testing a system in a store before purchase, and quick testing of a 
> new system shipped with Windows to determine whether it needs to be 
> returned before reformatting the harddisk and installing Linux.
> 
> The reports I've know are for KT133 motherboards.  Have problems been 
> reported with the KT266 DDR-SDRAM chipsets as well?

As I write this a friend is repairing a lost partition on his FIC AZ11E 
motherboard (KT133 chipset), apparently due to a BIOS bug..

> 
> All the best, Eric Olson
