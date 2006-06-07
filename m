Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWFGDiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWFGDiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWFGDiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:38:16 -0400
Received: from hera.kernel.org ([140.211.167.34]:9192 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750790AbWFGDiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:38:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Tue, 6 Jun 2006 20:37:56 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e65hmk$ljv$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <448366FB.1070407@zytor.com> <20060606152041.GA5427@ucw.cz> <200606062256.55472.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149651476 22144 127.0.0.1 (7 Jun 2006 03:37:56 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jun 2006 03:37:56 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200606062256.55472.rjw@sisk.pl>
By author:    "Rafael J. Wysocki" <rjw@sisk.pl>
In newsgroup: linux.dev.kernel
> > 
> > It allows me to unify swsusp & uswsusp into one in future, for
> > example, reducing code duplication.
> 
> [cough] How distant is the future you're referring to?
> 

Shouldn't be far, since most of the code is already written.

One major advantage of klibc is that it allows most of the
initialization code to both be re-used as standalone programs as well
as be tested in normal userspace.  The former lets distributions
stitch it together any way they want, and the latter should reduce
bugs (especially since it's combined with what is a decent-sized
subset of the POSIX programming model, as opposed to the much more
difficult kernel programming model.)

	-hpa

