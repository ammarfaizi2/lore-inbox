Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVLFPK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVLFPK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLFPK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:10:29 -0500
Received: from mail.enyo.de ([212.9.189.167]:21211 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964977AbVLFPK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:10:27 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<1133620264.2171.14.camel@localhost.localdomain>
	<20051203193538.GM31395@stusta.de>
	<1133639835.16836.24.camel@mindpipe>
	<20051203225815.GH25722@merlin.emma.line.org>
	<87y82z5kep.fsf@mid.deneb.enyo.de>
	<1133816764.9356.72.camel@laptopd505.fenrus.org>
	<87mzjf2gxs.fsf@mid.deneb.enyo.de>
	<20051206112127.GE10574@merlin.emma.line.org>
Date: Tue, 06 Dec 2005 16:10:25 +0100
In-Reply-To: <20051206112127.GE10574@merlin.emma.line.org> (Matthias Andree's
	message of "Tue, 6 Dec 2005 12:21:27 +0100")
Message-ID: <87acfep8gu.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Andree:

> On Tue, 06 Dec 2005, Florian Weimer wrote:
>
>> From a vendor POV, the lack of official kernel.org advisories may be a
>> feature.  I find it rather disturbing, and I'm puzzled that the kernel
>> developer community doesn't view this a problem.  I know I'm alone,
>
> You're not alone in viewing this as a problem, 

I know, it's a typo.

> How about the Signed-off-by: lines? Those people who pass on the changes
> also pass on the bugs, and they are responsible for the code - not only
> license-wise, but also quality-wise. That's the latest point where
> regression tests MUST happen.

There are critical kernel parts for which automated regression testing
is very hard.  In some twisted sense, regression testing ist best done
by those who run real applications, i.e. end users.  The interesting
thing is that you end up with reasonably stable software this way,
except in a few corner cases.

The main point of debate seems to be how relevant the corner cases
are, and how much general kernel development should care about them.
(And no, not everyone in such a corner has $$,$$$ to spend.)
