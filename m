Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUANQc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUANQc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:32:58 -0500
Received: from intra.cyclades.com ([64.186.161.6]:30899 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261827AbUANQc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:32:57 -0500
Date: Wed, 14 Jan 2004 14:23:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org, Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: 2.4.24 SMP lockups
In-Reply-To: <20040111090135.GB6834@netnation.com>
Message-ID: <Pine.LNX.4.58L.0401141420090.14071@logos.cnet>
References: <Pine.LNX.4.58L.0401101758010.1310@logos.cnet>
 <20040111090135.GB6834@netnation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jan 2004, Simon Kirby wrote:

> On Sat, Jan 10, 2004 at 05:58:18PM -0200, Marcelo Tosatti wrote:
>
> > This sounds like a deadlock. I wonder why the NMI watchdog is not
> > triggering.
>
> It appears the box I was expecting it to work onn has issues with the NMI
> working properly, so that may explain why nothing was showing up.  I'll
> try on others.
>
> > Can you share all available SysRQ-P output for the locked CPU ? SysRQ-T if
> > possible, too.
>
> Will do, in the next few days.
>
> > Can you please describe the hardware in more detail. Is there any common
> > hardware used in these boxes?
>
> The CPUs, motherboards, SCSI, Ethernet, etc., are all different... They
> are all SMP, and are fairly busy web servers.

I'm stress testing 2.4.24 on a 8-way SMP server with AIC7xxx from OSDL.
I'm using apachebench.

Lets see how it goes. Ill receive an SMP box with AIC7xxx this week
probably. As soon as it arrives Ill run the tests there too.
