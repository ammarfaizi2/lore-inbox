Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264232AbRFUAV6>; Wed, 20 Jun 2001 20:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbRFUAVs>; Wed, 20 Jun 2001 20:21:48 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:43483 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264083AbRFUAVf>; Wed, 20 Jun 2001 20:21:35 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Date: Wed, 20 Jun 2001 17:21:26 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKEEOHPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <XFMail.20010620154145.davidel@xmailserver.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 20-Jun-2001 David Schwartz wrote:

> >> On Wed, Jun 20, 2001 at 02:01:16PM -0700, David Schwartz wrote:

> >> >    It's very hard to use processes for this purpose. Consider,
> >> > for example, a
> >> > web server. You don't want to use one process for each client
> >> > because that
> >> > would limit your scalability (16,000 clients would become
> >> > difficult, and
> >> > with threads it's trivial). You don't want to use one thread
> >> > for each client

> >> How is it trivial? How do you debug a 16,000 thread application?

> > As I said, you don't want to use one thread for each
> > client. You use,
> > say, 10 threads for the 16,000 clients.

> Humm, you're going to select() over 1600 fds ...

	Who said anything about 'select'? If you want to learn how to write
efficient multi-threaded servers, take a course or read a book. Heck, you
can even ask me questions on marginally appropriate lists or even by private
email. But don't put words in my mouth.

	DS

