Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTJ3BwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 20:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTJ3BwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 20:52:22 -0500
Received: from thunk.org ([140.239.227.29]:12431 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262098AbTJ3BwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 20:52:21 -0500
Date: Wed, 29 Oct 2003 20:52:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Erik Andersen <andersen@codepoet.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030015212.GD8689@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Erik Andersen <andersen@codepoet.org>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029224230.GA32463@codepoet.org>
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

Keep in mind that just because Windows does thing a certain way
doesn't mean we have to provide the same functionality in exactly the
same way.

Also keep in mind that Microsoft very deliberately blurs what they do
in their "kernel" versus what they provide via system libraries (i.e.,
API's provided via their DLL's, or shared libraries).

At some level what they have done can be very easily replicated by
having a userspace database which is tied to the filesystem so you can
do select statements to search on metadata assocated with files.  We
can do this simply by associating UUID's to files, and storing the
file metadata in a MySQL database which can be searched via
appropriate userspace libraries which we provide.

Please do **not** assume that just because of the vaporware press
releases released by Microsoft that (a) they have pushed an SQL Query
optimizer into the kernel, or that (b) even if they did, we should
follow their bad example and attempt to do the same.  

There are multiple ways of skinning this particular cat, and we don't
need to blindly follow Microsoft's design mistakes.

Fortunately, I have enough faith in Linus Torvalds' taste that I'm not
particularly worried what would happen if someone were to send him a
patch that attempted to cram MySQL or Postgres into the guts of the
Linux kernel....  although I would like to watch when someone proposes
such a thing!

						- Ted
