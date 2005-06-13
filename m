Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVFMWDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVFMWDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFMWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:00:18 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:18151 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261491AbVFMV7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:59:01 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <42ADB4E4.2010504@redhat.com>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>
	 <1118655702.2840.24.camel@localhost.localdomain>
	 <20050613110556.GA26039@infradead.org>
	 <20050613111422.GT22349@devserv.devel.redhat.com>
	 <1118661848.2840.34.camel@localhost.localdomain>
	 <42ADA880.60303@redhat.com>
	 <1118678548.25956.200.camel@hades.cambridge.redhat.com>
	 <42ADAFE5.5050206@redhat.com>
	 <1118680177.25956.213.camel@hades.cambridge.redhat.com>
	 <42ADB4E4.2010504@redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 22:58:42 +0100
Message-Id: <1118699922.14833.0.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 09:31 -0700, Ulrich Drepper wrote:
> I don't see the need for higher precision in this API and a change is
> confusing.  There is nanosleep() for people who only want a delay and
> that can be done with high precision.

If that's the case, might one enquire as to why pselect() has a struct
timespec instead of a struct timeval?

Or would the answer just depress me?
> 
-- 
dwmw2


