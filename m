Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268201AbTB1WDp>; Fri, 28 Feb 2003 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268209AbTB1WDp>; Fri, 28 Feb 2003 17:03:45 -0500
Received: from dhcp-66-212-193-131.myeastern.com ([66.212.193.131]:64448 "EHLO
	mail.and.org") by vger.kernel.org with ESMTP id <S268201AbTB1WDo>;
	Fri, 28 Feb 2003 17:03:44 -0500
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Protecting processes from the OOM killer
References: <3E5EB9A8.3010807@kegel.com>
	<1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
	<3E5F8985.60606@kegel.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 28 Feb 2003 17:13:56 -0500
In-Reply-To: <3E5F8985.60606@kegel.com>
Message-ID: <m3smu82guz.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@kegel.com> writes:

> Alan Cox wrote:
> > On Fri, 2003-02-28 at 01:21, Dan Kegel wrote:
> >
> > Everything else is armwaving "works half the time" stuff. By the time
> > the OOM kicks in the game is already over.
> 
> Even with overcommit disallowed, the OOM killer is going to run
> when my users try to run too big a job, so I would still like
> the OOM killer to behave "well".

 If OOM is called you've overcommitted memory, so this isn't true
... no overcommit == NULL from malloc() etc.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
