Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVJGLIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVJGLIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVJGLIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:08:17 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:20618 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751364AbVJGLIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:08:16 -0400
Date: Fri, 7 Oct 2005 07:08:10 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <Pine.LNX.4.58.0510061122530.418@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510070706100.6608@localhost.localdomain>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
 <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu>
 <Pine.LNX.4.58.0510061122530.418@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I was compiling a kernel in a shell that I set to a priority of 20, and it
locked up on the bit_spin_lock crap of jbd.  Did you want me to send you
that patch again that adds another spinlock to the buffer head and uses
that instead of the bit_spins?

-- Steve


