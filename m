Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVBBTaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVBBTaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVBBTaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:30:18 -0500
Received: from mail.joq.us ([67.65.12.105]:39860 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262509AbVBBT3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:29:52 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu>
	<20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
	<20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
	<87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu>
	<873bwfo8br.fsf@sulphur.joq.us>
	<1107370770.3104.136.camel@krustophenia.net>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 02 Feb 2005 13:31:12 -0600
In-Reply-To: <1107370770.3104.136.camel@krustophenia.net> (Lee Revell's
 message of "Wed, 02 Feb 2005 13:59:30 -0500")
Message-ID: <87pszikbcv.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 2005-02-01 at 23:10 -0600, Jack O'Quin wrote:
>> Is nobody responsible for figuring out what users need?  I didn't
>> realize kernel development had become so disconnected.

Lee Revell <rlrevell@joe-job.com> writes:
> IMHO the requirements gathering process usually works well.  When
> someone with a redhat.com (for example) address posts a patch there's an
> implicit assumption that it addresses the needs of their gadzillions of
> users.  Still, RH hires professional kernel developers, people who
> produce known good code will always have an easier time getting patches
> merged.  If Linus & co. don't know you from Adam and you show up with a
> patch that claims to solve a big problem, then I would expect them to be
> a bit skeptical.  Especially if the problem is either low priority or
> not well understood by the major distros.

I guess you're right, Lee.  I hadn't thought of it that way.  It just
looks broken to me because we have no standing in any normal kernel
requirements process.  That's a shame, but it does seem less like a
systemic issue.

I think the distributions are getting more interested in these issues.
Maybe that will help.  The RT-LSM is available as a module in Debian
sarge.

Back when I did OS development for a living, there was a huge focus on
defining user requirements.  But, our kernel development was never
organizationally separate from the rest of the OS.  That makes a big
difference.
-- 
  joq
