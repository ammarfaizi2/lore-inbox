Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTJKSXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTJKSXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:23:30 -0400
Received: from the.earth.li ([193.201.200.66]:53937 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S263366AbTJKSX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:23:28 -0400
Date: Sat, 11 Oct 2003 19:23:28 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-kernel@vger.kernel.org
Subject: Interrupt routing (was Re: 8139too & APIC incompatibility (2.6.0-test6-mm1, 2.4.20))
Message-ID: <20031011182328.GL30375@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929165550.GA6526@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003 16:59:32, Jeff Garzik wrote:
> On Mon, Sep 29, 2003 at 03:47:29PM +0000, Andreas Schwarz wrote:
[snip tranmit timed out error]
> > After this has happened the first time, the card fails to send or
> > receive any more packages.
> Yes.  Has nothing to do with 8139too, though.
> 
> This is one of 1001 similar symptoms of the same problem, "interrupt
> routing bug(s)".

Bugs where? Does this count as a hardware issue or a software issue? I'm
seeing similar problems with DLink 580TX boards (sundance driver) and
both SiS 730 and Intel Camino chipsets, under 2.4.21 (and .22). I've
seen a suggestion that ACPI might help, but no definite answers. Equally
no mention of what hardware is a good choice if that's the root cause.

J.

-- 
                 /------------------------------------\
                 |   Zed's dead, baby. Zed's dead.    |
                 | http://www.blackcatnetworks.co.uk/ |
                 \------------------------------------/
