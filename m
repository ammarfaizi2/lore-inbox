Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbTCGWHq>; Fri, 7 Mar 2003 17:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbTCGWHq>; Fri, 7 Mar 2003 17:07:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22792 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261808AbTCGWHp>; Fri, 7 Mar 2003 17:07:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] one line fix in arch/i386/Kconfig
Date: 7 Mar 2003 14:18:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4b5r4$cii$1@cesium.transmeta.com>
References: <20030307220337.5841.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030307220337.5841.qmail@linuxmail.org>
By author:    "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
In newsgroup: linux.dev.kernel
>
> Hi all,
> this is the first time I post a patch to the list,
> therefore I'm really not sure if it is correct,
> even if it is just a 'one line patch'
> 
> If I say that my cpu is not a PentiumIV why
> he bothers me about "check for P4 thermal throttling interrupt." ?
> 

Because you might be compiling a kernel for a more baseline CPU, say a
486, but still check for thermal throttle if it's present.

> This patch show that option only if you select that kind of CPU.
> 
> Is it correct ? Does it makes sense ?

No.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
