Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSHNShW>; Wed, 14 Aug 2002 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHNShW>; Wed, 14 Aug 2002 14:37:22 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:22987 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315388AbSHNShV>;
	Wed, 14 Aug 2002 14:37:21 -0400
Date: Wed, 14 Aug 2002 20:41:12 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200208141841.UAA23040@harpo.it.uu.se>
To: alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: GA-7DX+ crashes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wed, 14 Aug 2002 10:08:50 -0700 (PDT), Alex Davis wrote:
>>We have no information on
>>workarounds (or if they are needed) for the AMD/VIA combo other than the
>>fact that the APIC cannot be used on them according to AMD docs.
>
>Really?? I have an Epox 8k7a (AMD761 North / VIA South) that I've been using for
>over a year now with APIC configured. In fact I'm sure I remember (haven't checked
>recently) one of the boot messages being 'found and enabled local APIC'. Am I 
>missing something??

Alan was a bit careless in his wording. He most likely meant the
IO-APIC, which is broken in some/all(?) AMD north / VIA south combos.
AMD has an errata sheet on this issue.

/Mikael
