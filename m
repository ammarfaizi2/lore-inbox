Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135607AbRD2FNn>; Sun, 29 Apr 2001 01:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135592AbRD2FNe>; Sun, 29 Apr 2001 01:13:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135607AbRD2FNX>; Sun, 29 Apr 2001 01:13:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Date: 28 Apr 2001 22:13:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9cg7t7$gbt$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
By author:    Richard Gooch <rgooch@ras.ucalgary.ca>
In newsgroup: linux.dev.kernel
> > 
> > In x86-64 there are special vsyscalls btw to solve this problem that export
> > a lockless kernel gettimeofday()
> 
> Whatever happened to that hack that was discussed a year or two ago?
> The one where (also on IA32) a magic page was set up by the kernel
> containing code for fast system calls, and the kernel would write
> calibation information to that magic page. The code written there
> would use the TSC in conjunction with that calibration data.
> 
> There was much discussion about this idea, even Linus was keen on
> it. But IIRC, nothing ever happened.
> 

We discussed this at the Summit, not a year or two ago.  x86-64 has
it, and it wouldn't be too bad to do in i386... just noone did.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
