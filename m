Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135459AbRAYW3M>; Thu, 25 Jan 2001 17:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135466AbRAYW3C>; Thu, 25 Jan 2001 17:29:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59148 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135459AbRAYW2v>; Thu, 25 Jan 2001 17:28:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: x86 PAT errata
Date: 25 Jan 2001 14:28:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <94q9ag$9bs$1@cesium.transmeta.com>
In-Reply-To: <200101251745.SAA07063@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200101251745.SAA07063@harpo.it.uu.se>
By author:    Mikael Pettersson <mikpe@csd.uu.se>
In newsgroup: linux.dev.kernel
>
> Before people get too exited about the x86 Page Attribute Table ...
> Does Linux use mode B (CR4.PSE=1) or mode C (CR4.PAE=1) paging?
> If so, known P6 errata must be taken into account.
> In particular, Pentium III errata E27 and Pentium II errata A56
> imply that only the low four PAT entries are working for 4KB
> pages, if CR4.PSE or CR4.PAE is enabled.
> 

All of the above.  Sounds like PAT should be declared broken on these
chips.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
