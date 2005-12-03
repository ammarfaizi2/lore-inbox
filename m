Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVLCRfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVLCRfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVLCRfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:35:17 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:54795 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932100AbVLCRfP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:35:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DjHCvW9H6Tw1aDt24gbuFXGCn0eke5eb+xCbQVec35ONoLDmUEUf6VRXGjfZhBOLSykazdJFAsiZ8bEB2UubApjATz4vIT8LDLjCid4XaIVOF2PLeUHvx7wJvwJ6Hzeyf8bQYStmErJSuGDH/qLF0+jkDQYmx4sJkJ0SmMEkEZ0=
Message-ID: <f0cc38560512030935p61dda1bq10b52fa5ec393846@mail.gmail.com>
Date: Sat, 3 Dec 2005 18:35:13 +0100
From: "M." <vo.sinh@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1133630556.22170.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <1133630556.22170.26.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

Here to expose my point of view, hope u'll enjoy :)

Starting stable series off the 2.6 simply wouldn't work: there are no
paid QA guys ready to test, fix, stabilize those series, kernel
developers wants to hang on new exciting stuff.
This tendence leads to faster innovations in kernel core and features
set but leaving the "forking" effort to distributions leads to
fragmentation too: almost every distro has a different base kernel on
which doing testing and fixing and this, in my opinion, is not
positive for the kernel.org kernels. Another problem of the current
development model is that fast changes are difficult to track for
small external projects (those whitout big $$ behind), the small
projects which made linux so great in the past.
Maybe a way to reduce those problems is to release the kernel like
GNOME, KDE, fedora & co. do for their stuff: one stable release every
6 months but build on top of the current way of doing things. Example:

2.6.14 released on 27 October, then:
  2.6.14.1-gitN until 2.6.14.1-rcN -> 2.6.14.1
  2.6.14.2-gitN until 2.6.14.2-rcN -> 2.6.14.2
  ...
  (maybe last 2.6.14-N, which could be called 2.6.15-gitN ->
2.6.15-rcN, only bugfixes and small changes, main development in -mm
or in a new -something tree during this last phase)
2.6.15 release on March

those middle releases would be handled with the current development
model except for the last one. So, the largest part of developers
would continue to think and to work using the current development
model and some guys would be able to plan a list of features and
functionalities every 6 months and, based on this list, handle the
6-months release giving guide lines (like Linus and friends already do
but, i repeat, focusing on a 6 months time window)

Doing things this way would lead to distributions aligning to the same
kernel and open up a possible scenario of distros collaborating to
mantain the latest stable release. This should make small projects and
users who want to run bleeding edge stuff lifes easier too.

of couse the time window could be larger or smaller but doing things
6months-based should align kernel development to some other big
projects too.


cheers,
Michele
