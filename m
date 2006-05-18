Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWERMPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWERMPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWERMPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:15:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28397 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750741AbWERMPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:15:36 -0400
Date: Thu, 18 May 2006 14:14:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 1/3] reliable stack trace support
Message-ID: <20060518121451.GB1585@elf.ucw.cz>
References: <4469FC07.76E4.0078.0@novell.com> <20060518111625.GA2026@elf.ucw.cz> <446C7F0A.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446C7F0A.76E4.0078.0@novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 18-05-06 14:04:58, Jan Beulich wrote:
> >> +/*
> >> + * Copyright (C) 2002-2006 Novell, Inc.
> >> + *	Jan Beulich <jbeulich@novell.com>
> >> + *
> >> + * A simple API for unwinding kernel stacks.  This is used for
> >> + * debugging and error reporting purposes.  The kernel doesn't need
> >> + * full-blown stack unwinding with all the bells and whistles, so there
> >> + * is not much point in implementing the full Dwarf2 unwind API.
> >
> >Missing GPL?
> 
> I took include/asm-ia64/unwind.h's header as a template - is there anything wrong with that?

Yes, I'd say. That one needs fixing, too.

I guess one line before copyright, saying "Distribute under GPL",
"This file is released under the GPLv2", or something like that would
be enough.
								Pavel
		(goes on fixing drivers/block/nbd.c)
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
