Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUJYQLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUJYQLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUJYQJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:09:01 -0400
Received: from cantor.suse.de ([195.135.220.2]:13489 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262032AbUJYQGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:06:07 -0400
Date: Mon, 25 Oct 2004 18:06:06 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Kleen <ak@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/17] Generic backward compatibility includes for 4level
Message-ID: <20041025160606.GA26306@verdi.suse.de>
References: <417CAA05.mail3Y411778M@wotan.suse.de> <20041025103926.A31632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025103926.A31632@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:39:26AM +0100, Russell King wrote:
> On Mon, Oct 25, 2004 at 09:23:49AM +0200, Andreas Kleen wrote:
> > +/* Included by architectures that don't have a fourth page table level.
> > +
> > +   pml4 is simply casted to pgd */
> > +
> > +#define pml4_ERROR(x) 
> 
> Don't we normally add do { } while (0) after empty macros which look like
> a function?

iirc Rusty tried to come up with an example some time ago where it actually 
made a difference, but failed. But I can change it. 

-Andi

