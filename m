Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422950AbWBBKG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422950AbWBBKG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBBKG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:06:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45452 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932453AbWBBKG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:06:57 -0500
Date: Thu, 2 Feb 2006 11:06:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060202100646.GC1981@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602012245.06328.nigel@suspend2.net> <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com> <200602020730.16916.nigel@suspend2.net> <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 01-02-06 23:45:15, Pekka Enberg wrote:
> On Wednesday 01 February 2006 23:01, Pekka Enberg wrote:
> > > I think we can call these suspend_{get|set}_modules instead i.e.
> > > without the extra '2'.
> 
> On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > I wanted to avoid confusion with similar routine names Pavel might use. For
> > example, he has a resume_setup and I have a resume2_setup.
> 
> Is that necessary for the mainline, though? We have only one suspend
> in the kernel, not "Pavel suspend" and "Nigel suspend", right?

Actually plan is to only have "Rafael suspend" :-). That's basically
"Pavel suspend" minus the disk writing parts. That is *long* term.
								Pavel
-- 
Thanks, Sharp!
