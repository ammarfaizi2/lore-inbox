Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbVJ1VKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbVJ1VKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbVJ1VKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:10:05 -0400
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115]:13585 "HELO
	mpls-qmqp-04.inet.qwest.net") by vger.kernel.org with SMTP
	id S1751696AbVJ1VKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:10:03 -0400
Date: Fri, 28 Oct 2005 16:12:49 -0500
Message-ID: <000701c5dc04$5b31d6e0$4bc80443@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: jonathan@jonmasters.org
Cc: linux-kernel@vger.kernel.org
References: <000501c5daf1$bbd37c60$e8c90443@oemcomputer> <35fb2e590510270822q39db180fh530ce80bb9ec57ba@mail.gmail.com> <000701c5db43$86209060$25c60443@oemcomputer> <35fb2e590510280242h53c8c444t8d285198d7c6730f@mail.gmail.com>
Subject: Re: yet another c language cross-reference for linux
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jon Masters" <jonmasters@gmail.com>
Sent: Friday, October 28, 2005 4:42 AM

> On 10/27/05, Paul Albrecht <palbrecht@qwest.net> wrote:
>
> > I simply disagree that the lxr user interface is useable for code study.
>
> Although many people use it for that, so it must be useable.

I don't think lxr is a suitable tool for code study, but if it works for you
that's ok with me.

>
> > The problem with the lxr interface stems from the author's decision to use basic
> > html for query responses to the database;
>
> You don't cite an example of where this fails. The only practical
> limitation I've seen in lxr is that it doesn't index certain symbols
> which arrive through complex defines (and this is a place where asking
> the compiler for help *is* useful).
>
> > Actually, I'm uninterested in data presentation issues or I'd make the
> > changes myself. What's really different about my cross-reference application
> > is that the database is generated using compiler output.
>
> That is a good idea.
>
> > the cross-reference database is coherent in the sense that its derived from
> > a particular kernel compilation. The advantage of this approach is that it
> > reduces the size and ensures the integrity of the cross-reference database.
>
> coherency is the wrong term here. The database in both should be as
> they're derived from a static kernel tree (if not, then there are
> other problems). But I'll agree that your idea (I haven't yet checked
> the implementation - it was very short) in theory is a good one. LXR
> still works great though :-)
>

I'm defining coherency in the sense that the database is derived from a
particular kernel configuration; that is, I'm only considering files compiled or
included for a particular kernel compilation. That's a good thing or a bad thing
depending on what you're trying to accomplish. If, for example, you're only
interested in an i386 kernel configuration, then you're probably not interested
in files and includes for ppc, s390, etc.

Paul Albrecht

