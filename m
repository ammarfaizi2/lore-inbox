Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBGRoq>; Wed, 7 Feb 2001 12:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRBGRoh>; Wed, 7 Feb 2001 12:44:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36882 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129144AbRBGRo0>; Wed, 7 Feb 2001 12:44:26 -0500
Message-ID: <3A818939.5BD3B740@transmeta.com>
Date: Wed, 07 Feb 2001 09:43:21 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <20010207135824.A24476@vana.vc.cvut.cz>
		<3A817F68.1A5C4EC1@transmeta.com> <14977.34686.377279.606313@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
>  > In other words, I'd like to see a reason for making any vendor-specific
>  > determinations, and if so, they should ideally be centralized to the CPU
>  > feature-determination code.
> 
> The Pentium 4 has a local APIC. It's not 100% compatible with the P6, and
> you sometimes have to know which one you're poking. CPUID returns the
> APIC feature bit. Should we mask its APIC capability? Of course not.
> 

What's so "of course" about it?  It mostly depends on how ugly the
determination is.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
