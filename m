Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUAMBbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUAMBbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:31:22 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:42254 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262827AbUAMBbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:31:21 -0500
Date: Tue, 13 Jan 2004 09:30:06 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Tim Hockin <thockin@hockin.org>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <20040112225023.GA21399@hockin.org>
Message-ID: <Pine.LNX.4.33.0401130928480.10047-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Tim Hockin wrote:

> On Mon, Jan 12, 2004 at 11:26:30AM -0500, Mike Waychison wrote:
> > /usr   /man1   server:/usr/man1   \
> >          /man2   server:/usr/man2
> >
> > is the same as the two distinct entries:
> >
> > /usr/man1   server:/usr/man1
> > /usr/man2   server:/usr/man2
> >
> > Now that I think about it, the discussion in my proposal paper about
> > multimounts with no root offsets probably isn't required.
>
> The latter requires /usr/man1 and /usr/man2 to exist.  The former only
> requires /usr to exist, right?
>

That's one possibility, but man1 and man2 could simply not call filler in
the readdir call.

Ian


