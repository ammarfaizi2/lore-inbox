Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTELHb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 03:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTELHb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 03:31:28 -0400
Received: from tomts26.bellnexxia.net ([209.226.175.189]:63641 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261970AbTELHb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 03:31:27 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Slab corruption mm3 + davem fixes
Date: Mon, 12 May 2003 03:44:50 -0400
User-Agent: KMail/1.5.9
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       laforge@netfilter.org
References: <20030511031940.97C24251B@oscar.casa.dyndns.org> <20030511151506.172eee58.akpm@digeo.com> <1052692449.4471.4.camel@rth.ninka.net>
In-Reply-To: <1052692449.4471.4.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305120344.50347.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2003 06:34 pm, David S. Miller wrote:
> > > Yeah, more bugs in the NAT netfilter changes.  Debugging this one
> > > patch is becomming a full time job :-(

But you do it well...  Looks like this fixes the slab problems here with
69-bk from Sunday am.

> > > This should fix it.  Rusty, you're computing checksums and mangling
> > > src/dst using header pointers potentially pointing to free'd skbs.
> >
> > Did you mean to send a one megabyte diff?
>
> Let's try this again, here is the correct patch :-)

Thanks
Ed Tomlinson
