Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTJOQwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTJOQwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:52:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263620AbTJOQwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:52:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Date: 15 Oct 2003 09:52:01 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bmjtvh$1k5$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk> <20031015124314.GD20846@lug-owl.de> <20031015130614.GI765@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031015130614.GI765@holomorphy.com>
By author:    William Lee Irwin III <wli@holomorphy.com>
In newsgroup: linux.dev.kernel
> 
> Well, unless it's an interrupts-safe critical section that's hurting,
> you could take profiles, provided you have enough RAM for the profile
> buffer (which appears to be large). You could easily do a quick hack
> to steal the profile buffer from e820 regions not otherwise used for
> RAM (i.e. unused because you did mem=) to handle that for a slow cpu
> with more RAM than 8MB.
> 

Or just reduce mem= by enough less that you gain the profile buffer
back.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
