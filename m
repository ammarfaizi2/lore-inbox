Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316638AbSEVSRy>; Wed, 22 May 2002 14:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316640AbSEVSRx>; Wed, 22 May 2002 14:17:53 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:43746 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316638AbSEVSRv>;
	Wed, 22 May 2002 14:17:51 -0400
Date: Wed, 22 May 2002 11:17:51 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020522111751.A10992@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020522103834.B10921@bougret.hpl.hp.com> <E17Aams-0002Ue-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 07:24:37PM +0100, Alan Cox wrote:
> > 	Alan,
> > 	Could you be more precise and point out which kernel start
> > failing ?
> 
> Certainly in 2.4.18 (and I've seen a pile of other similar reports).

	2.4.18 did upgrade the driver from 0.06f to 0.09b. The bug
with 0.09b is a race condition in Tx code. This was fixed in version
0.11.
	Have you tried 2.4.19-pre8-acX (well, I mean the Orinoco
driver in 2.4.19-pre8 ;-). It contains the new version of the driver
(v11) that fixes the race condition (but introduce the potential COR
problem).
	If 2.4.19-pre8-acX fails, that would be for an entirely
different reason (even if the failure might look similar).

> Any specific info/debug/traces that would help ?

	I'll defer that to David.

> Alan

	Good luck...

	Jean
