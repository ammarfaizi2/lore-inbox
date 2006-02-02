Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWBBLjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBBLjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWBBLjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:39:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37795 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750810AbWBBLjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:39:24 -0500
Date: Thu, 2 Feb 2006 12:39:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060202113911.GF1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012245.06328.nigel@suspend2.net> <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com> <200602020730.16916.nigel@suspend2.net> <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com> <20060202100646.GC1981@elf.ucw.cz> <84144f020602020257g72bda32bkc3d6264495bea2aa@mail.gmail.com> <20060202110235.GE1884@elf.ucw.cz> <84144f020602020316x1a996f74u8099df2696c716b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84144f020602020316x1a996f74u8099df2696c716b4@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 13:16:40, Pekka Enberg wrote:
> Hi,
> 
> On St 01-02-06 23:45:15, Pekka Enberg wrote:
> > > So what's the plan for short-term? Are userspace suspend and suspend
> > > modules mutually exclusive or can they co-exist?
> 
> On 2/2/06, Pavel Machek <pavel@ucw.cz> wrote:
> > They can coexist for as long as neccessary. (At one point, it was even
> > possible to suspend using userland code, then resume using kernel code
> > :-).
> >
> > When I found out noone is really using kernel code any more (2.8.0 or
> > something), I'd like to get rid of it.
> 
> So are you saying we should pursue merging Suspend2 bits in the
> mainline and deprecate it when userspace is mature enough and has all
> the same features? Seems counter-productive but then again I am mostly
> clueless of suspend issues.

No, I'm saying that suspend2 bits should be moved into userspace. That
way we get mature userspace much faster, without any big merge into
kernel.
								Pavel
-- 
Thanks, Sharp!
