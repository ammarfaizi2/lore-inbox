Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUJZUQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUJZUQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUJZUOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:14:09 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:60177 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261440AbUJZUNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:13:42 -0400
Date: Wed, 27 Oct 2004 00:14:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jean-Christophe Dubois <jdubois@mc.com>,
       kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH 2.6.9] kbuild warning fixes on Solaris 9
Message-ID: <20041026221408.GB30918@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Jean-Christophe Dubois <jdubois@mc.com>, kai@germaschewski.name,
	sam@ravnborg.org
References: <20041025224907.GL25154@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025224907.GL25154@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:49:07PM -0700, Tom Rini wrote:
> The following set of patches is based loosely on the patches that
> Jean-Christophe Dubois came up with for 2.6.7.  Where as the original
> patches added a number of casts to unsigned char, I went the route of
> making the chars be explicitly signed.  I honestly don't know which
> route is better to go down.  Doing this is the bulk of the patch.  Out
> of the rest of the odds 'n ends is that on Solaris, Elf32_Word is a
> ulong, which means all of the printf's are unhappy (uint format, ulong
> arg) for most of the typedefs.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Comments?  Beatings?  Thanks.

Looks much better. Applied.

	Sam

