Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSDXLj3>; Wed, 24 Apr 2002 07:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSDXLj2>; Wed, 24 Apr 2002 07:39:28 -0400
Received: from ns.suse.de ([213.95.15.193]:42765 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311841AbSDXLj2>;
	Wed, 24 Apr 2002 07:39:28 -0400
Date: Wed, 24 Apr 2002 13:39:27 +0200
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.19-pre6aa1 (i586) ?
Message-ID: <20020424133927.C14343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020423092731.GA6327@smart.cobolt.net> <20020423150709.A4982@dualathlon.random> <20020424085458.GC9292@smart.cobolt.net> <20020424132505.M29841@suse.de> <20020424113249.GA30841@smart.cobolt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 01:32:49PM +0200, Dennis Schoen wrote:
 > > > opel:~# ./ewbe
 > > > HWCR=               2
 > > > Current EWBE mode is strong ordering
 > > 
 > > Bah, told you it was a long shot. Oh well..
 > Hhm, could you (or someone else) explain me what that output means?

It's a decoded version of one of the CPU registers that describes the
ordering model of the memory.  The K6-2 / K6-3 have iirc 3 different
settings here, weak, notsoweak, strong. Weak ordering is faster, but
may show up strange bugs. Which after Andrea pointed out that the
function in the oops was unlikely to erm, oops, I got wondering if
perhaps your BIOS had programmed it too aggressively.

But, this was just a random thought that didn't prove right, so
back to the drawing board.. 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
