Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTGHXgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTGHXgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:36:09 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:33036 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265486AbTGHXgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:36:07 -0400
Date: Wed, 9 Jul 2003 00:50:39 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Pavel Machek <pavel@suse.cz>, <vojtech@suse.cz>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
In-Reply-To: <20030709002322.D13083@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307090049020.32323-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > This needs to be migrated to the new power management code.
> > 
> > What exactly should it do? Suspend machine? Then it needs to do
> > equivalent of "echo 3 > /proc/acpi/sleep", but I do not think we have
> > generic interface for that...
> 
> It looks like it was intended to call an old version of the suspend
> code on ARM devices - probably the power button on the iPAQ.

Yeap. I wrote that code for use on a iPAQ. I was hoping for a generic
interface for this some time in 2.5.X. 
 
> The correct function (in the ARM tree) is now called "suspend()" and
> deals with suspending the devices and then whatever is needed to cause
> the CPU to go into deep sleep - ie, the user visible "power off" state.

Needs updating :-)
 

