Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbRL2W1Z>; Sat, 29 Dec 2001 17:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL2W1P>; Sat, 29 Dec 2001 17:27:15 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18089
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287200AbRL2W1J>; Sat, 29 Dec 2001 17:27:09 -0500
Date: Sat, 29 Dec 2001 15:27:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 1.12 is available
Message-ID: <20011229222706.GD21928@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <19466.1009506702@ocs3.intra.ocs.com.au> <10706.1009614471@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10706.1009614471@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 07:27:51PM +1100, Keith Owens wrote:
> Content-Type: text/plain; charset=us-ascii
> 
> On Fri, 28 Dec 2001 13:31:42 +1100, 
> Keith Owens <kaos@ocs.com.au> wrote:
> >This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.
> >Patches for other architectures and kernels will be out later today, it
> >takes time to generate and test patches for 6 architectures against 3
> >different kernel trees.
> 
> All architecture and tree specific patches for kbuild 2.5 are now
> available, if you don't see your arch then nobody has sent me a patch
> yet.
[snip]
> kbuild-2.5-2.4.16-ppc-1		Add on for ppc by Tom Rini.

This seems to have been generated (or applied originally) w/ the wrong
-p level (I suspect 'cuz of the wierd way I created the diff tho), since
this creates ./ppc/.., instead of ./arch/ppc/...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
