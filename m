Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272069AbTHRPge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272070AbTHRPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:36:34 -0400
Received: from dp.samba.org ([66.70.73.150]:62372 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S272069AbTHRPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:36:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters 
In-reply-to: Your message of "Mon, 18 Aug 2003 13:09:55 +0100."
             <20030818120955.GB7147@mail.jlokier.co.uk> 
Date: Tue, 19 Aug 2003 01:32:59 +1000
Message-Id: <20030818153632.98AF22C0DA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030818120955.GB7147@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > In message <20030818004618.GA5094@mail.jlokier.co.uk> you write:
> > > The largest "unsigned int" value doesn't fit in a "long", on many machines.
> > > So we should use simple_strtoul, not simple_strtol, to decode these values.
> > 
> > Half right.  The second part is fine, the first part is redundant
> 
> Do you mean the first part of the comment or the first part of the patch?
> 
> Assuming you mean the patch, you're right: the unsigned short case
> doesn't need to be changed.  It should be anyway because it is just
> the right thing to do.

<shrug>.  Linus took the patch.  If you think it's the Right Thing,
great.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
