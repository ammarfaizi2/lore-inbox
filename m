Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUKCBxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUKCBxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUKCBxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:53:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:11736 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261318AbUKCBxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:53:10 -0500
Date: Tue, 2 Nov 2004 17:52:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info 
In-Reply-To: <Pine.LNX.4.58.0411021747420.2187@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411021750440.2187@ppc970.osdl.org>
References: <20041101162929.63af1d0d.akpm@osdl.org> 
 <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
 <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com>  <5109.1099394496@redhat.com>
 <Pine.LNX.4.58.0411021747420.2187@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Nov 2004, Linus Torvalds wrote:
> 
> That may not be true today, but what is true is that -O1 is not a light 
> thing to just do.

And btw, in some cases the inlining used to be a correcness issue, so no,
just making it be "static inline" doesn't necessarily fix the basic issue. 

Again, whether that is necessarily true today is not something I'm ready 
to guarantee one way or the other, so this is just an observation that 
things can be a lot more subtle than you seem to assume.

		Linus
