Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282300AbRK2Cir>; Wed, 28 Nov 2001 21:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282301AbRK2Cih>; Wed, 28 Nov 2001 21:38:37 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:16637 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S282300AbRK2Ci2>; Wed, 28 Nov 2001 21:38:28 -0500
Date: Wed, 28 Nov 2001 16:33:44 -0800
From: Chris Wright <chris@wirex.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011128163344.D14584@figure1.int.wirex.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com> <20011128010411.A14584@figure1.int.wirex.com> <20011128044001.C3921@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011128044001.C3921@holomorphy.com>; from wli@holomorphy.com on Wed, Nov 28, 2001 at 04:40:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> On Wed, Nov 28, 2001 at 01:04:11AM -0800, Chris Wright wrote:
> > boot: 2.5.1-pre1-bootmem
> > Uncompressing image...
> > Loading initial ramdisk....
> > PROMLIB: obio_ranges 5
> > Fixup b f01e9720 doesn't refer to a SETHI at f0119e34[7fffc344]
> > Program terminated
> > Type  help  for more information
> > <#0> ok         
> 
> 
> I'd be interested in finding out what this error means. Can anyone
> comment on this?

i recompiled with DEBUG_BOOTMEM enabled, and it booted fine.  that macro
only turns on a couple printk's, so i suspect i messed up the first
build.  after rebuilding without DEBUG_BOOTMEM again, and booting
sucessfully, i'd say it's working fine on this 32-bit SPARC20
 
here's the debug output, btw:
  
Available physical memory:
vailable segment: [66347008,66424831]
available segment: [2396160,2400255]
available segment: [5623808,16777215]
available segment: [17096704,66342911]
 
cheers,
-chris
