Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbUKWLmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbUKWLmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 06:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUKWLmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 06:42:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6111 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262427AbUKWLmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 06:42:32 -0500
Date: Tue, 23 Nov 2004 05:02:52 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Philippe Troin <phil@fifi.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend/resume ceased to work with 2.4.28
Message-ID: <20041123070252.GA2712@logos.cnet>
References: <87zn1amuov.fsf@ceramic.fifi.org> <20041122173654.GA31848@logos.cnet> <87mzx94ekm.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzx94ekm.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 04:03:05PM -0800, Philippe Troin wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> 
> > On Sun, Nov 21, 2004 at 07:25:20PM -0800, Philippe Troin wrote:
> > > Seen on a Dell Inspiron 3800 with BIOS revision A17.
> > > 
> > > APM suspend/resume works perfectly with 2.4.27 (or at least, as well
> > > as APM can).
> > > 
> > > Since I did not see any differences in arch/i386/kernel/apm.c between
> > > .27 and .28, I'm at loss to explain the problem.
> > 
> > Guess: Are you using ACPI ? 
> 
> ACPI is compiled in, but the kernel is booted with noacpi...
> 
> Phil.

Phil, 

Can you please try 2.4.28-pre3 ? 

Lets try to find out where it started to happen. I've got no clue, 
there are no indeed no APM related changes in 2.4.28.
