Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbTDVAB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 20:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbTDVAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 20:01:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16772 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262711AbTDVAB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 20:01:28 -0400
Date: Tue, 22 Apr 2003 01:13:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030422001330.GE17793@mail.jlokier.co.uk>
References: <20030421233557.GB17595@mail.jlokier.co.uk> <Pine.LNX.4.44.0304211705400.17938-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211705400.17938-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > Such as removing the lock prefix when running non-SMP?
> 
> I think you should use a separate mechanism for that. It's really a 
> separate issue, _and_ the replacement is actually quite different (and 
> much more common, so you'd want to use a more compact data structure that 
> is likely just the list of addresses of locked instructions).

Indeed.

-- Jamie
