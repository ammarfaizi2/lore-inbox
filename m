Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUCLS5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUCLS5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:57:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15247 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262389AbUCLS5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:57:53 -0500
Date: Fri, 12 Mar 2004 13:57:49 -0500 (EST)
From: Matthew Galgoci <mgalgoci@redhat.com>
X-X-Sender: mgalgoci@lacrosse.corp.redhat.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atkbd shaddup
In-Reply-To: <20040312183738.GA3233@thunk.org>
Message-ID: <Pine.LNX.4.44.0403121356560.28918-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Theodore Ts'o wrote:

> On Fri, Mar 12, 2004 at 12:37:06PM -0500, Matthew Galgoci wrote:
> > 
> > Andrew,
> > 
> > I can't be the only person to be annoyed by the "too many keys
> > pressed" error message that often gets spewed across the console
> > when I am typing fast. This patch turns that error message (and
> > others) into info message. Also, one debug message was turned into
> > info, and a couple of warnings were turned into info where I thought
> > it made sense.
> 
> I'd go even further.  Do we need to print the "too many keys pressed"
> message at *all*?  Why would anyone care?

I wondered the same thing. Maybe it should be #ifdef DEBUG'd instead of toned
down.

-- 
Matthew Galgoci
System Administrator
Red Hat, Inc
919.754.3700 x44155

