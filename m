Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWG3RAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWG3RAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWG3RAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:00:30 -0400
Received: from ns.suse.de ([195.135.220.2]:35042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751227AbWG3RA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:00:29 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
Date: Sun, 30 Jul 2006 18:48:56 +0200
User-Agent: KMail/1.9.3
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, nate.diller@gmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de> <20060729232625.c8bcac66.akpm@osdl.org> <1154275941.5784.131.camel@localhost>
In-Reply-To: <1154275941.5784.131.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301848.56121.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Not necessarily. AFAICS, the spam could be triggered by perfectly
> legitimate activity. For instance, someone on the server may have
> revoked your read permissions to the file, or may have deleted it.

I don't think any of this was the case in the cases I saw it.

It would be probably good to investigate post 2.6.18, but for 2.6.18
itself I think removing the printk was the best short term "fix".

> > Do we know why nfs's readpage isn't bringing the page up to date?
> 
> It may be that other lurking issues were also triggering the printk. For
> instance I know of a couple of corner cases in the krb5 privacy code
> that could result in readpage failing. Those issues are being looked
> into.

I don't use kerberos either.

-Andi
