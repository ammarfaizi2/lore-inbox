Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272048AbTHRPbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272050AbTHRPbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:31:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:1921 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S272048AbTHRPbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:31:16 -0400
Date: Mon, 18 Aug 2003 16:31:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters
Message-ID: <20030818153106.GA8044@mail.jlokier.co.uk>
References: <20030818101524.5B12D2C019@lists.samba.org> <Pine.LNX.4.44.0308180817360.1672-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308180817360.1672-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 18 Aug 2003, Rusty Russell wrote:
> > Half right.  The second part is fine, the first part is redundant
> > AFAICT.
> 
> Well, in theory short/int/long can all be the same size and thus a
> "unsigned short" may not actually fit in a "long". I think that was the
> case on the old 64-bit cray machines, for example ("char" was a very slow
> 8-bit thing, everything else was purely 64-bit).

There's the SHARC and C4x architectures, where "char" is 32 bits, the
same as "short", "int" and "long".

-- Jamie
