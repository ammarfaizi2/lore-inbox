Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWIRRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWIRRoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWIRRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:44:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33180 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751863AbWIRRoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:44:06 -0400
Subject: Re: tracepoint maintainance models
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060918172705.GN3951@redhat.com>
References: <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com>
	 <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com>
	 <20060918150231.GA8197@elte.hu>
	 <1158594491.6069.125.camel@localhost.localdomain>
	 <20060918152230.GA12631@elte.hu>
	 <1158596341.6069.130.camel@localhost.localdomain>
	 <20060918161526.GL3951@redhat.com>
	 <1158598927.6069.141.camel@localhost.localdomain>
	 <20060918172705.GN3951@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 19:04:22 +0100
Message-Id: <1158602662.6069.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 13:27 -0400, ysgrifennodd Frank Ch. Eigler:
> Unless one's worried about planetary-scale energy use, I see no point
> in multiplying overheads by "every box on the planet".

Because we are all paying for your debug stuff we aren't using. Systems
get slow and sucky by the death of a million cuts not by one stupid
action.

> Unfortunately, cases in which this sort of out-of-band markup would be
> sufficient are pretty much those exact same cases where it is not
> necessary.  Remember, the complex cases occur when the compiler munges
> up control flow and data accessability, so debuginfo cannot or does
> not correctly place the probes and their data gathering compatriots.

Which if understand you right you'd end up unmunging and reducing
performance for by reducing the options gcc has to make that critical
code go fast just so you know what register something is living in.

Alan
