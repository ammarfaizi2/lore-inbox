Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271393AbTG2LJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTG2LJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:09:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:42248 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S271405AbTG2LHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:07:34 -0400
Date: Tue, 29 Jul 2003 13:14:23 +0200
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The well-factored 386
Message-ID: <20030729111423.GA5320@hh.idb.hist.no>
References: <03072809023201.00228@linux24> <20030728093245.60e46186.davem@redhat.com> <20030728194127.GA10673@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728194127.GA10673@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 08:41:27PM +0100, Jamie Lokier wrote:
> I didn't realise he was talking about an x86 emulator.  I thought he
> was analyzing real hardware.
> 
> The one thing that made it on-topic for me was his quiet suggestion
> that "forreal" mode interrupts are faster, and that it might, perhaps,
> be possible to modify a Linux kernel to run in that mode - to take
> advantage of the faster interrupts.

That would have to be a kernel for very special use.  The "forreal"
mode has protection turned off.  As far as I know, that
means any user process can take over the cpu as if
it was running in kernel mode.

Perhaps useful for some embedded use with only a couple well-tested
processes running.  Still, a programming error could overwrite
kernel memory instead of segfaulting.

Helge Hafting
