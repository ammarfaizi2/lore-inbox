Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTLBSQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTLBSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:16:51 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:25472 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262731AbTLBSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:16:22 -0500
Date: Tue, 2 Dec 2003 18:20:04 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312021820.hB2IK4Wv000220@81-2-122-30.bradfords.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031202160853.GB22608@gtf.org>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
 <200312011226.04750.nbensa@gmx.net>
 <20031202115436.GA10288@physik.tu-cottbus.de>
 <20031202120315.GK13388@conectiva.com.br>
 <20031202131311.GA10915@physik.tu-cottbus.de>
 <3FCC95BB.60205@wmich.edu>
 <20031202160136.GB10915@physik.tu-cottbus.de>
 <20031202160853.GB22608@gtf.org>
Subject: Re: Linux 2.4 future
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jeff Garzik <jgarzik@pobox.com>:
> On Tue, Dec 02, 2003 at 05:01:36PM +0100, Ionut Georgescu wrote:
> > I can understand that, but I don't take 2.6 for an answer.  2.4 is not
> > yet dead and it won't be for a long time, just as 2.2 has gotten to
> > 2.2.25, although 2.4.0 was out when, 3 years ago ?
> 
> 2.4 has continued life, yes.
> 
> But the real question is, should 2.4 continue to be developed?
> 
> I agree with Marcelo, increasingly the answer should be "No".  New
> features and core changes should be intended for 2.6.  Bug fixes,
> security errata, and the like will always be OK for 2.4.  Just like Alan
> continues to release new 2.2.x releases, when major bugs are found.

Even doing that becomes increasingly difficult when you have fewer and
fewer systems actually running the code.

Backporting a security fix to 2.0.x, and touching some core code,
could easily result in something breaking and it going unnoticed for
months, especially if it is something that's hard to trigger.

John.
