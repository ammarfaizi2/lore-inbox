Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTKXOX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 09:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTKXOX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 09:23:27 -0500
Received: from maggie.ininet.com ([207.22.50.134]:44391 "EHLO
	maggie.ininet.com") by vger.kernel.org with ESMTP id S263526AbTKXOX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 09:23:27 -0500
Subject: Re: Kernel oops at boot with 2.6.0-test9, 2.4.21ELsmp on Opteron
	248
From: Paul Venezia <pvenezia@ininet.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1069497027.6256.0.camel@laptop.fenrus.com>
References: <1069453947.3807.2341.camel@soul.jpj.net>
	 <1069497027.6256.0.camel@laptop.fenrus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1069683566.10182.2.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Nov 2003 09:19:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-22 at 05:30, Arjan van de Ven wrote:
> On Fri, 2003-11-21 at 23:32, Paul Venezia wrote:
> > I meant to include more complete traces in my previous post, but I'm
> > having some odd problem with serial consoles on this box so I only get
> > partial clean output. Here's what I can gather at the moment:
> > 
> 
> this may be a case of "the" bios bug; could you try passing "idle=poll"
> to the kernel ?
> If that helps you need a newer bios....
> 

I had checked for a newer BIOS for this board, but there isn't a newer
version available. Passing idle=poll permits the RH 2.4.21EL-smp kernel
to boot, and mysql is now functional. 2.6.0-test9, test9-smp, test10,
and test10-smp still will not boot.

-Paul
