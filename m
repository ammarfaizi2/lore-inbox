Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290386AbSAPJRI>; Wed, 16 Jan 2002 04:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290393AbSAPJRE>; Wed, 16 Jan 2002 04:17:04 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:25728
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290391AbSAPJQS>; Wed, 16 Jan 2002 04:16:18 -0500
Date: Wed, 16 Jan 2002 04:00:31 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020116040031.A3445@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <esr@thyrsus.com> <200201151920.g0FJK09j002000@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201151920.g0FJK09j002000@tigger.cs.uni-dortmund.de>; from brand@jupiter.cs.uni-dortmund.de on Tue, Jan 15, 2002 at 08:20:00PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <brand@jupiter.cs.uni-dortmund.de>:
> > Actually I think we may no longer be in tristate-land.  Instead, some
> > devices have the property "This belongs in initramfs if it's configured
> > at all" -- specifically, drivers for potential boot devices.  Everything
> > else can dynamic-load after boot time.  
> 
> Then all SCSI drivers end up in the initramfs for the install kernel for
> a distro? There might be _many_ devices configured that don't need to
> reside on the initramfs.

No worries.  I have working code for a better approach now.  It turns
out not to be that hard to discover the root device, controller, and bus.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The end move in politics is always to pick up a gun.
	-- R. Buckminster Fuller
