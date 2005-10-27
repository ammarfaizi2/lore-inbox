Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbVJ0WKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbVJ0WKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVJ0WKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:10:07 -0400
Received: from mpls-qmqp-03.inet.qwest.net ([63.231.195.114]:40969 "HELO
	mpls-qmqp-03.inet.qwest.net") by vger.kernel.org with SMTP
	id S932671AbVJ0WKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:10:06 -0400
Date: Thu, 27 Oct 2005 17:12:29 -0500
Message-ID: <000701c5db43$86209060$25c60443@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: jonathan@jonmasters.org
Cc: linux-kernel@vger.kernel.org
References: <000501c5daf1$bbd37c60$e8c90443@oemcomputer> <35fb2e590510270822q39db180fh530ce80bb9ec57ba@mail.gmail.com>
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
Sent: Thursday, October 27, 2005 10:22 AM

> On 10/27/05, Paul Albrecht <palbrecht@qwest.net> wrote:
>
> > I have written another cross-referencing tool for the c language because I
> > have been dissatisfied with existing tools such as ctags and lxr.
>
> Ok.
>
> > I'd like to get some feedback to determine whether other programmers
> > find the program useful
>
> It seems to be in its very early stages now. I can barely navigate the
> 2.4.31 source and it doesn't offer anything like the functionality of
> lxr. But if you want to, perhaps it's worthwhile developing it further
> and releasing it.
>
> Your README file suggests that LXR fails because it requires a
> webserver. Personally, I've never seen that to be an issue and find it
> very very useful indeed (although it has limitations and doesn't
> always index every symbol I would want to lookup), especially with
> coywolf keeping an up-to-date lxr for 2.6. Mel Gorman used it for his
> ULVMM book and I'm sure others are using LXR extensively - so it might
> be worth extending that.
>
> I'd love it if vendors would actually index their kernels with LXR.
>
> Jon.

I simply disagree that the lxr user interface is useable for code study. The
problem with the lxr interface stems from the author's decision to use basic
html for query responses to the database; this severely constrains the
user interface. A better approach would be to use dynamic html or provide
the database access as a service and write the user interface as a mozilla
client application.

Actually, I'm uninterested in data presentation issues or I'd make the
changes myself. What's really different about my cross-reference application
is that the database is generated using compiler output. As a result,
the cross-reference database is coherent in the sense that its derived from
a particular kernel compilation. The advantage of this approach is that it
reduces the size and ensures the integrity of the cross-reference database.

Paul Albrecht

