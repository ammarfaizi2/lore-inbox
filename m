Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261214AbREUPR0>; Mon, 21 May 2001 11:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbREUPRQ>; Mon, 21 May 2001 11:17:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54027 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261214AbREUPRD>; Mon, 21 May 2001 11:17:03 -0400
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
Date: 21 May 2001 08:16:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ebbg2$m62$1@tazenda.transmeta.com>
In-Reply-To: <3B090C81.53F163C3@TeraPort.de>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3B090C81.53F163C3@TeraPort.de>
By author:    "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
>  while trying to enhance a small hardware inventory script, I found that
> cpuinfo is missing the details of L1, L2 and L3 size, although they may
> be available at boot time. One could of cource grep them from "dmesg"
> output, but that may scroll away on long lived systems.
> 

Any particular reason this needs to be done in the kernel, as opposed
to having your script read /dev/cpu/*/cpuid?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
