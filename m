Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbUKKWDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbUKKWDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUKKWAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:00:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:20434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262376AbUKKV77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:59:59 -0500
Date: Thu, 11 Nov 2004 13:59:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiser{3,4}: problem with the copyright statement
In-Reply-To: <20041111214554.GB2310@stusta.de>
Message-ID: <Pine.LNX.4.58.0411111355020.2301@ppc970.osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org> <20041111214554.GB2310@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Nov 2004, Adrian Bunk wrote:
> 
> I have no problem with dual-licensed code, but I do strongly dislike 
> having this "unlike you explicitley state otherwise, you transfer all 
> rights to Hans Reiser" in the kernel.

I don't see any reasonable alternatives. The alternative is for Hans 
Reiser to not be able to merge with the kernel, which is kind of against 
the _point_ of having a dual license.

If the wording grates or assignment is an issue (and yes, in the US you 
technically really need to have an express _signed_ assignment, implied 
assignments just don't work), asking people to make their changes PD 
instead might work (they'd obviously immediately be subsumed under the GPL 
as far as the kernel is concerned, but would allow the dual-licensing to 
continue to work).

That said, I don't think at least _this_ particular area has been 
problematic, because quite frankly, very few people end up working on 
other peoples filesystems, so as far as I can tell, almost all reiserfs 
fixes have really been mainlt due to interface changes, nothing else. So 
assignment of copyright etc doesn't really ever become an issue, if only 
because copyrights require a bit of actual artistic value ;)

		Linus
