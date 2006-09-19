Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWISQlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWISQlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWISQlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:41:52 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:9620 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030239AbWISQlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:41:51 -0400
In-Reply-To: <4510151B.5070304@google.com>
Subject: Re: [PATCH] Linux Kernel Markers
To: Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, systemtap@sources.redhat.com,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       Tom Zanussi <zanussi@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OFAEBEF5BB.1D00BC3E-ON802571EE.005B7AF8-802571EE.005BB61E@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 19 Sep 2006 17:41:43 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 19/09/2006 17:44:01
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Bligh <mbligh@google.com> wrote on 19/09/2006 17:04:43:

> Frank Ch. Eigler wrote:
> > Hi -
> >
> > On Tue, Sep 19, 2006 at 08:11:40AM -0700, Martin J. Bligh wrote:
> >
> >
> >>[...]  Why don't we just copy the whole damned function somewhere
> >>else, and make an instrumented copy (as a kernel module)? Then
> >>reroute all the function calls through it [...]
> >
> >
> > Interesting idea.  Are you imagining this instrumented copy being
> > built at kernel compile time (something like building a "-g -O0"
> > parallel)?  Or compiled anew from original sources after deployment?
> > Or on-the-fly binary-level rewriting a la SPIN?
>
> "compiled anew from original sources after deployment" seems the most
> practical to do to me. From second hand info on using systemtap, you
> seem to need the same compiler and source tree to work from anyway, so
> this doesn't seem much of a burden.
>

If I'm not mistaken, this has been done before under the guise of dynamic
patch. Doesn't Solaris have the capability? I'm certain that some UNIXes do
as well as non-UNIX O/Ss.

Richard

