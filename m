Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287417AbSAHRSR>; Tue, 8 Jan 2002 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSAHRSH>; Tue, 8 Jan 2002 12:18:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287417AbSAHRRz>; Tue, 8 Jan 2002 12:17:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Date: 8 Jan 2002 09:17:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1f9j9$5i9$1@cesium.transmeta.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca> <20020108111302.A14860@mould.bodgit-n-scarper.com> <20020108201451.088f7f99.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020108201451.088f7f99.rusty@rustcorp.com.au>
By author:    Rusty Russell <rusty@rustcorp.com.au>
In newsgroup: linux.dev.kernel
> 
> It's unfortunate that /proc/sys and /proc suck so hard that good coders go
> to great lengths to do anything else [see previous /proc/sys patches].
> 

/proc/sys is pretty cool.  However, procfs has no permission control
system set up, unlike /dev.  This is inherent; adjusting sysctls is a
root-only function and cannot be made otherwise.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
