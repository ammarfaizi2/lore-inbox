Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUCLSiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUCLSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:38:07 -0500
Received: from thunk.org ([140.239.227.29]:39565 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262399AbUCLShw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:37:52 -0500
Date: Fri, 12 Mar 2004 13:37:38 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Galgoci <mgalgoci@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atkbd shaddup
Message-ID: <20040312183738.GA3233@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matthew Galgoci <mgalgoci@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403121228100.28918-100000@lacrosse.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403121228100.28918-100000@lacrosse.corp.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
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

On Fri, Mar 12, 2004 at 12:37:06PM -0500, Matthew Galgoci wrote:
> 
> Andrew,
> 
> I can't be the only person to be annoyed by the "too many keys
> pressed" error message that often gets spewed across the console
> when I am typing fast. This patch turns that error message (and
> others) into info message. Also, one debug message was turned into
> info, and a couple of warnings were turned into info where I thought
> it made sense.

I'd go even further.  Do we need to print the "too many keys pressed"
message at *all*?  Why would anyone care?

						- Ted
