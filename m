Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288757AbSAIDRN>; Tue, 8 Jan 2002 22:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288758AbSAIDRD>; Tue, 8 Jan 2002 22:17:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52740 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288757AbSAIDQz>; Tue, 8 Jan 2002 22:16:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Date: 8 Jan 2002 19:16:30 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1gcme$18t$1@cesium.transmeta.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <20020108201451.088f7f99.rusty@rustcorp.com.au> <a1f9j9$5i9$1@cesium.transmeta.com> <20020109120108.39bcf7ad.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020109120108.39bcf7ad.rusty@rustcorp.com.au>
By author:    Rusty Russell <rusty@rustcorp.com.au>
In newsgroup: linux.dev.kernel
> 
> Incorrect.  See my new /proc/sys implementation patch.  It's hidden in the
> flames somewhere...
> 

So you chown an entry, then a module is unloaded and reloaded, now
what happens?

It's the old "virtual filesystem which really wants persistence" issue
again...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
