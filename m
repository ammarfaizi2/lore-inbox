Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTDOLx7 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDOLx7 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:53:59 -0400
Received: from ns.suse.de ([213.95.15.193]:33555 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261290AbTDOLx5 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:53:57 -0400
Date: Tue, 15 Apr 2003 14:05:24 +0200
From: Andi Kleen <ak@suse.de>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5
Message-ID: <20030415120524.GA13567@wotan.suse.de>
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel> <p73adesxane.fsf@oldwotan.suse.de> <yw1xptno7yxe.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xptno7yxe.fsf@zaphod.guide>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 02:00:45PM +0200, M?ns Rullg?rd wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > > What magic needs to be done when writing modules for linux 2.5.x?
> > > Insmod tells me "Invalid module format" and the kernel log says "No
> > > module found in object".  I've tried to mimic the foo.mod.c stuff in
> > > the kernel tree, but I can't figure out the right way to do it.
> > 
> > Welcome to the wonderful new world of in kernel module loading, finally
> > with understandable error messages. Now bad error reporting is not limited
> > to netlink anymore.
> > 
> > You need -DKBUILD_BASENAME=name
> 
> Should I also add -DKBUILD_MODNAME=name?

Yes.

-Andi
