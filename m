Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSLCRNx>; Tue, 3 Dec 2002 12:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSLCRNx>; Tue, 3 Dec 2002 12:13:53 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:43705 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S261874AbSLCRNw>;
	Tue, 3 Dec 2002 12:13:52 -0500
Date: Tue, 3 Dec 2002 12:21:23 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP Pentium4 -- PAUSE Instruction
In-Reply-To: <1038931576.20262.0.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.33L2.0212031221090.1780-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


:)  Oh.  Don't I feel like I hit the panic button too early... :/

-Calin

On 3 Dec 2002, Arjan van de Ven wrote:

> On Tue, 2002-12-03 at 16:42, Calin A. Culianu wrote:
>
> > Is this instruction being used in spin-wait loops?  For some reason, I am
> > having a hard time figuring out whether or not it is being used.  There is
> > a rep_nop() in processor.h.. but I can't determine if that is being called
> > for spin lock lock/unlock code.
>
> check cpu_relax() all over the kernel :)
> and the spinlock code uses it inside it's own asm directly, not via
> rep_nop()
>
>

