Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbTCGXAn>; Fri, 7 Mar 2003 18:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTCGXAn>; Fri, 7 Mar 2003 18:00:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261838AbTCGXAm>; Fri, 7 Mar 2003 18:00:42 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] one line fix in arch/i386/Kconfig
Date: 7 Mar 2003 15:10:42 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4b8ti$cq8$1@cesium.transmeta.com>
References: <20030307223202.9244.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030307223202.9244.qmail@linuxmail.org>
By author:    "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
In newsgroup: linux.dev.kernel
> > 
> > We want people to be able to build a kernel which will run on many systems
> > but still use CPU specific features. 
> 
> Ah... ok I see the point, I could compile a kernel with PIII optimizations
> and then run it on a PIV. 
> 
> But it is a complication in the configuration process.
> Do we agree on that ?
>

Not really.

> 
> How about a config entry:
> "Leave only the option related to the CPU I selected" ?
> 

What we really need is to separate out "optimize for CPU" and "support
CPU", kind of like gcc has -mcpu= and -march=.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
