Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUAXXVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAXXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:21:17 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:11925
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263166AbUAXXVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:21:16 -0500
Date: Sat, 24 Jan 2004 18:32:04 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Illegal instruction with gl
Message-ID: <20040124183204.A8493@animx.eu.org>
References: <20040123181512.A6632@animx.eu.org> <20040124103919.A7924@animx.eu.org> <20040124154249.GA2499@redhat.com> <20040124111235.A2757@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20040124111235.A2757@animx.eu.org>; from Wakko Warner on Sat, Jan 24, 2004 at 11:12:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I see no evidence that this is an agpgart problem.  When that does something
> > wrong, you usually end up with either a system lockup, or massive memory
> > corruption. Apps segfaulting would suggest to me that you have a problem with
> > your X GL libraries.
> > 
> > You may have more luck asking the folks at dri-devel@lists.sf.net about it.

I was using 4.2.1.1 from debian.  I just upgraded to 4.3.0 that's in debian
experimental and is now working.  I really don't know what's changed between
versions, but I can't understand why just changing the system board would
have caused this.  All I know is the fact that the old board used the
generic intel setup routines and this one uses 7505 (but I also changed it).

I guess the only thing is this board is too new for X to understand or
something.

I'd like to upgrade my video card, but I don't know what to get.  I've
looked at what 3D is supported by the kernel and looks like I'll be going
for an ATI card.  Any recommendations or a list of ati radeon cards that
work in 3D?

> Considering that all I did was change the motherboard, it could be an agp
> problem.  This same card, same kernel, everything worked on another system. 
> I did not change any other software other than the kernel.
> 
> The program did not segfault, it received illegal instruction.  The only
> driver that I had to change when I installed this board was the aic79xx. 
> The other system used an addon aic7xxx controller, this has a builtin
> aic7902 controller which houses /
> 
> I'll forward my same message to that list you mentioned.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
