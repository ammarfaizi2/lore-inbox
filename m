Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758524AbWK2BHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758524AbWK2BHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758549AbWK2BHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:07:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9150 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758524AbWK2BHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:07:51 -0500
Date: Tue, 28 Nov 2006 20:06:31 -0500
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 3/16] LTTng 0.6.36 for 2.6.18 : Linux Kernel Markers
Message-ID: <20061129010631.GD8910@redhat.com>
References: <20061124215401.GD25048@Krystal> <y0mu00kpawa.fsf@ton.toronto.redhat.com> <20061128023349.GA2964@Krystal> <20061128054036.GA29273@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128054036.GA29273@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Tue, Nov 28, 2006 at 05:40:36AM +0000, Christoph Hellwig wrote:
> [...]
> > > Are you sure the license_gplok check is necessary here?  We should
> > > consider encouraging non-gpl module writers to instrument their code,
> > > to give users a slightly better chance of debugging problems.

> > [... the authors of clearcase] have the funny habit of
> > distributing their kernel modules as ".ko" files instead of
> > sending a proper ".o" and later link it against a wrapper.  The
> > result is, I must say, quite bad [...]  the structure is
> > corrupted.

> Please don't add hacks like that for non-GPL modules.  

Indeed, offline Matheiu elaborated on his problem, and it turns out
that good old modversions would have solved it.

> But neither should we export any tracing functionality for them.
> They're not the kind of people we want to help at all,

Making that sort of political decision is beyond my pay grade.  
I merely suggested its consideration.

> and Frank just shows once again that he should rather stay away from
> kernel stuff and keep on writing C++.

Now now, if you don't like my C++, wait till you see my Smalltalk-80.
Or are you just jealous that my initials subsume yours?

- FChE (this space for rent)
