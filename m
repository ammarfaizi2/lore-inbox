Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264982AbUFALTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbUFALTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264983AbUFALTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:19:30 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:55052 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264982AbUFALT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:19:29 -0400
Date: Tue, 1 Jun 2004 21:19:25 +1000 (EST)
From: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why swap at all?
In-Reply-To: <20040601102448.GL2093@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0406012116010.5465@tellurium.ssi.swin.edu.au>
References: <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
 <S264961AbUFAJhd/20040601093733Z+1483@vger.kernel.org>
 <slrn-0.9.7.4-25709-3086-200406012010-tc@hexane.ssi.swin.edu.au>
 <20040601102448.GL2093@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004, William Lee Irwin III wrote:

> On Tue, Jun 01, 2004 at 08:13:59PM +1000, Tim Connors wrote:
> > Incidentally, what happens when kswapd becomes a zombie? I've seen
> > this a few times, and I am currently posting on a machine that has
> > been up for 15 days, and which oopsed 10 or so days ago (something to
                                   ^^^^^^^^^^^^^^^^^^^^^^^^
> > do with nfs, but don't worry about that - the machine is running
> > 2.4.20, and is not exactly up-to-date), killing kswapd.
> > But I don't notice anything at all different about how the system is
> > behaving. However, I haven't been doing much more than running emacs
> > and mozilla recently - I haven't been running my visualisation
> > software that typically stresses the VM beyond usefullness.
>
> Check your syslog for oopsen. That's the only known reason for kswapd
> to become a zombie.

What ill effects are meant to happen? I haven't noticed anything ill about
the machine at all. No OOMs, no 'failed zero order allocation', etc. Swap
is currently 508388k used, 543860k free, 175060k cached, mem is 498908k
used, 15540k free.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Error: Fuzzy Pointer Exception
