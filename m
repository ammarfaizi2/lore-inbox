Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUAJF5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUAJF5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:57:37 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:28164 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264889AbUAJF5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:57:36 -0500
Date: Sat, 10 Jan 2004 13:56:47 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Jim Carter <jimc@math.ucla.edu>
cc: Mike Waychison <Michael.Waychison@sun.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <Pine.LNX.4.53.0401091249250.9335@simba.math.ucla.edu>
Message-ID: <Pine.LNX.4.33.0401101347210.2403-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Jim Carter wrote:

> On Sat, 10 Jan 2004, Ian Kent wrote:
> > On Thu, 8 Jan 2004, Mike Waychison wrote:
> > > This module will have its own new autofs module (hopefully named
> > > something other than autofs to avoid confusion/mishaps).  The VFS will
>
> autofs v3 -> autofs.o
> autofs v4 -> autofs4.o
> May I suggest autofs5.o?  It should still be named "autofs-something",
> after all.
>

Nop. I will continue to develop under the v4 banner. As far as I'm
concerned Peter Anvin has claimed v5 and I don't want to challenge that.
Mike Waychisons' initiative may possibly be called v6???

In any case the module works fine with v3 and v4 (I haven't tested
4.0.0pre10 for a while though). The 4.1 daemon detects the enhanced module
if present. It is currently dubed 4.04. The 'plays well with others' is a
self imposed design requirement.

Ian


