Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTJUR0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJUR0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:26:44 -0400
Received: from thunk.org ([140.239.227.29]:54245 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263061AbTJUR0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:26:43 -0400
Date: Tue, 21 Oct 2003 13:23:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chris Wright <chrisw@osdl.org>
Cc: Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: cset #'s stable?
Message-ID: <20031021172304.GD4132@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Chris Wright <chrisw@osdl.org>, Frank Cusack <fcusack@fcusack.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20031021091347.A7526@google.com> <20031021095209.A32703@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021095209.A32703@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 09:52:09AM -0700, Chris Wright wrote:
> * Frank Cusack (fcusack@fcusack.com) wrote:
> > Are changeset #'s stable?
> > 
> > I'm specifically looking at linux-2.5/net/sunrpc/clnt.c,
> > "rev 1.1153.63.[123]" which I recorded earlier as 1.1153.48.[123].
> 
> No, they are not.  The key, however, is stable (bk changes -k -r<rev>,
> for example).

Changeset numbers are subject to change when you merge in other
changesets which depend on earlier changesets.  So older changeset
numbers tend to be more stable compared to newer changeset numbers,
and changeset numbers won't change unless you have done a pull (or
someone else has done a push) to your repository.

					- Ted
