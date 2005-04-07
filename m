Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVDGKyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVDGKyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVDGKyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:54:17 -0400
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:34706 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262424AbVDGKyN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:54:13 -0400
From: Andrew Walrond <andrew@walrond.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 11:54:01 +0100
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <87d5t73pnf.fsf@osv.topcon.com> <20050407103018.GA22906@merlin.emma.line.org>
In-Reply-To: <20050407103018.GA22906@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200504071154.01163.andrew@walrond.org>
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently switched from bk to darcs (actually looked into it after the author 
mentioned on LKML that he had imported the kernel tree). Very impressed so 
far, but as you say,

> 1. It's rather slow and quite CPU consuming and certainly I/O consuming

I expect something as large as the kernel tree would cause problems in this 
respect.

> 2. It has an impressive set of dependencies around Glasgow Haskell
>    Compiler. I don't personally have issues with that, but I can already
>    hear the moaning and bitching.

:) I try to built everthing from the original source, but in this case I 
couldn't. The GHC needs the GHC + some GHC addons in order  to compile 
itself...

>
> 3. DARCS is written in Haskell. This is not a problem either, but I'd
>    think there are fewer people who can hack Haskell than people who
>    can hack C, C++, Java, Python or similar. It is still better than

True, though as you say, not a show-stopper.

>From a functionality standpoint, darcs seem very similar to monotone, with a 
couple minor trade-offs in either direction.

I wonder if Linus would mind publishing his feature requests to the monotone 
developers, so that other projects, like darcs, would know what needs working 
on.

Andrew Walrond
