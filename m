Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVAMIXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVAMIXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAMIXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:23:31 -0500
Received: from mail.enyo.de ([212.9.189.167]:46467 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261203AbVAMIX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:23:27 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net>
	<Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<20050112185133.GA10687@kroah.com>
	<Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	<20050112161227.GF32024@logos.cnet>
	<Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	<20050112205350.GM24518@redhat.com>
	<Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
Date: Thu, 13 Jan 2005 09:23:26 +0100
In-Reply-To: <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> (Linus
	Torvalds's message of "Wed, 12 Jan 2005 18:09:31 -0800 (PST)")
Message-ID: <87oeftspoh.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> So I think the whole vendor-sec thing is not helping users at all, it's 
> purely a "vendor embarassment" thing. 

At least vendor-sec serves as a candidate naming authority for CVE,
and makes sure that the distributors use the same set of CANs in their
advisories.  For users, this is an important step forward, because
there is no other way to tell if vendor A is fixing the same problem
as vendor B, at least for end users.

In the past, the kernel developers (including you) supported the
vendor-sec process by not addressing security issues in official
kernels in a timely manner, and (what's far worse from a user point of
view) silently fixing security bugs in new releases, probably because
some vendor kernels weren't fixed yet.  Especially the last point
doesn't help users.
