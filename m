Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVFGA7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVFGA7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVFGA7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:59:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13975 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261780AbVFGA7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:59:07 -0400
Date: Tue, 7 Jun 2005 01:59:58 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Message-ID: <20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> <200506070105.20422.blaisorblade@yahoo.it> <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk> <200506070256.43104.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506070256.43104.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 02:56:36AM +0200, Blaisorblade wrote:
> > Per-subarch - perhaps not.  Per-glibc-type - definitely needed.
> No, because the setup for NPTL glibc works also on non-NPTL one. Actually, to 
> be exact, I've tested it *only* on normal glibc. I'm still waiting to get 
> some testing in NPTL environments, but I expect it to work.

Now, that is interesting.  Which script are you using for i386 and which
libc version does it work with?

> P.S: is it only me or you've sent about 20 copies of your last message?

Headers?
