Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVAGR4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVAGR4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVAGR4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:56:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:26307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261370AbVAGRxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:53:13 -0500
Date: Fri, 7 Jan 2005 09:53:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107095310.D2357@build.pdx.osdl.net>
References: <20050107144718.GB9606@infradead.org> <200501071526.j07FQG2g018486@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200501071526.j07FQG2g018486@localhost.localdomain>; from paul@linuxaudiosystems.com on Fri, Jan 07, 2005 at 10:26:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Davis (paul@linuxaudiosystems.com) wrote:
> So, we have a few responses, some references to various potential
> solutions all of which have problems just as deep if not deeper than
> the uid/gid-based model that this particular LSM adopts. No proposal
> for any system that would actually work and address anyone's real
> needs in a useful way.

I don't think that's quite true.  One repeated recommendation was to
simply generalize the idea so that it applies to all capabilities.
Another, which at this point appears quite workable, was Arjan's
recommendation to make scheduling policy/priority protected by an rlimit
(complicated only by representing the combinations sanely in a single
number).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
