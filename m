Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbTEPXuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbTEPXuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:50:23 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:24246 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264634AbTEPXuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:50:20 -0400
Subject: Re: 2.5.69-mm6: pccard oops while booting
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       davej@suse.de
In-Reply-To: <20030517005538.D26797@flint.arm.linux.org.uk>
References: <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>
	 <20030516132908.62e54266.akpm@digeo.com>
	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>
	 <3EC56173.1000306@gmx.net>
	 <1053128425.607.1.camel@teapot.felipe-alfaro.com>
	 <20030517005538.D26797@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1053129782.607.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 17 May 2003 02:03:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-17 at 01:55, Russell King wrote:
> On Sat, May 17, 2003 at 01:40:26AM +0200, Felipe Alfaro Solana wrote:
> > This is getting tricky. How about this one?
> > Attached is "ymfpci2.patch" with your suggested changes, and "dmesg"
> > with the new oops info.
> 
> You need to reproduce the oops you get when you modprobe the module.
> The oops with this driver built in is different, and akpm's changes
> won't tell us which one causes the problem.
> 
> Instead of adding a character to each of those strings, could you
> remove the 'Y' character so the strings remain the same length as
> the original - that may cause the oops to reappear.

Yeah! That's exactly what Carl proposed in a previous message. So, I
did, but now I can't reproduce the oops with ymfpci compiled as a
module. I can only reproduce the oops if ymfpci is built-into the
kernel.

Wops! I'm lost. I'm tired and it's too late, so I'd better get some
sleep and try to guess a little bit more tomorrow.

Thanks!

