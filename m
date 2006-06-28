Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWF1Wql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWF1Wql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWF1Wql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:46:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56006 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751629AbWF1Wqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:46:40 -0400
Date: Thu, 29 Jun 2006 00:46:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@kde.org>
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm)
Message-ID: <20060628224625.GD27526@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606290019.17298.sebas@kde.org> <20060628222417.GA27526@elf.ucw.cz> <200606290038.01733.sebas@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606290038.01733.sebas@kde.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-06-29 00:37:57, Sebastian Kügler wrote:
> On Thursday 29 June 2006 00:24, Pavel Machek wrote:
> > > > Okay, can I get some details? Like how much memory does system have,
> > > > what stress test causes the failure?
> > >
> > > The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB
> > > usually made swsusp a problem. I'd need to close apps then to be able to
> > > suspend.
> >
> > I'm pretty sure I do suspending with most of RAM full. You have
> > big-enough swap partition, right?
> 
> 1 GB, it might not be completely empty though. I probably only hit swsusp 
> limit much earlier than suspend2's (which after 34 suspend/resume cycles and 
> heavy use in between I did not hit yet). 

Okay, can we get bugzilla.kernel.org report? (assigned-to me)

This really should not happen, and I did not see swsusp fail like that
for quite a long time. I _could_ make it fail with make -j on kernel,
and similar crazy loads, but on nothing reasonable.

dmesg from failed run would be nice, too.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
