Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290477AbSAYBUb>; Thu, 24 Jan 2002 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290479AbSAYBUT>; Thu, 24 Jan 2002 20:20:19 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:28569 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S290477AbSAYBUK>; Thu, 24 Jan 2002 20:20:10 -0500
Date: Thu, 24 Jan 2002 19:19:04 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: ivan <ivan@es.usyd.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Physical memory versus detected memory 2.4.7-10
Message-ID: <20020124191904.A5529@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.33.0201251110180.31632-100000@dipole.es.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201251110180.31632-100000@dipole.es.usyd.edu.au>; from ivan@es.usyd.edu.au on Fri, Jan 25, 2002 at 12:05:10PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I don't know about that specific machine, but HP LP6000 boxes
reserve 700MB (!) for PCI hot-plug support.  So my 4GB boxes are
actually 3.3GB boxes.  Can't override it, says HP.  They wouldn't refund
70% of the price of a 1GB stick, either. ;)

I suspect what you're seeing is along the same lines; perhaps PCI
hotplug or some other reservation that may be tweakable in the PowerEdge
BIOS.  Dell may or may not be able to help.

FWIW; good luck,
-- 
Ken.
brownfld@irridia.com

On Fri, Jan 25, 2002 at 12:05:10PM +1100, ivan wrote:
| 
| Dear list users.
| 
| My server detects less memory than it available. 
| 
| 	Available memory according to the BIOS 4049MB.
| 
| 	System sees only 3.7GB ???
| 	Mem:  3799580K av, 1606816K used, 2192764K free, 468K shrd, 376972K buff
| 	Swap: 8192992K av, 0K used, 8192992K free 1037532K cached
| 
| 
| OS RedHat 2.7 standard kernel.
| 	Linux atlas.es.usyd.edu.au 2.4.7-10smp #1 SMP Mon Dec 10 13:08:57 EST 2001 i686 unknown
| 
| Hardware PowerEdge 4400. 
| 	( supports 4GB )
| 
| Additional problem:  
| 	random crushes, trying to to find out why.
| 
| Questions : 	1) Any comments on why top only shows 3.7 Gb are welcome.
| 
| 
| Thank you.
| ================================================================================
| 
| Ivan Teliatnikov,
| F05 David Edgeworth Building,
| Department of Geology and Geophysics,
| School of Geosciences,
| University of Sydney, 2006
| Australia
| 
| e-mail: ivan@es.usyd.edu.au
| ph:  061-2-9351-2031 (w)
| fax: 061-2-9351-0184 (w)
| 
| ===============================================================================
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
