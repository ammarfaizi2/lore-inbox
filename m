Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135888AbRDTMcT>; Fri, 20 Apr 2001 08:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135891AbRDTMcJ>; Fri, 20 Apr 2001 08:32:09 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:5649 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S135888AbRDTMcB>; Fri, 20 Apr 2001 08:32:01 -0400
Date: Fri, 20 Apr 2001 13:31:54 +0100
From: Roger Gammans <roger@computer-surgery.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Good example of the kind of thing the cross-referencer turns up.
Message-ID: <20010420133154.A25169@knuth.computer-surgery.co.uk>
In-Reply-To: <20010419131738.A2970@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20010419131738.A2970@thyrsus.com>; from Eric S. Raymond on Thu, Apr 19, 2001 at 01:17:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 01:17:38PM -0400, Eric S. Raymond wrote:
> Go on.  Tell me this isn't an error...
> 
> CONFIG_ARCH_CLPS7110: arch/arm/kernel/arch.c
> CONFIG_ARCH_CLPS711X: arch/arm/Makefile arch/arm/config.in arch/arm/kernel/Makefile arch/arm/kernel/entry-armv.S arch/arm/kernel/debug-armv.S arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/integrator
> 
> Somebody forgot an edit.  I wonder what bits got permanently conditioned out?

Don't know. I think the  CONFIG_ARCH_CLPS7110 is a stub refering to
mine and Werner's (2.2) PDA port, which AFAIK hasn't been mergerd.

I think CONFIG_ARCH_CLPS711X is a completely seperate port done
by a different group to the evaluaiton boards and similiar.

I'm not sure but that's certianly what it looks like to me, I
was hoping Russell might have said something more useful.

TTFN
-- 
Roger
     Think of the mess on the carpet. Sensible people do all their
     demon-summoning in the garage, which you can just hose down afterwards.
        --     damerell@chiark.greenend.org.uk
	
