Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUEYRQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUEYRQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUEYRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:15:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:61857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264984AbUEYRPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:15:20 -0400
Date: Tue, 25 May 2004 10:15:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Collins <bcollins@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <20040525131139.GW1286@phunnypharm.org>
Message-ID: <Pine.LNX.4.58.0405251012260.9951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
 <20040525131139.GW1286@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Ben Collins wrote:
>
> I've got a question about this. A lot of times I get patches that are
> just one/two-liners and the explanation is somewhat self-explantory,
> etc. Say the patch comes to me from some patch collection maintainer,
> who got it from the original author.
> 
> So the original person never put a Signed-off-by, and neither did the
> person who sent me the patch, should I still add the eplicit
> Signed-off-by's to the patch, and add myself, before sending it to you?

You should never sign off for somebody else.

You _can_ sign off as yourself, and just add a note of "From xxxx". That's
what the (b) case is all about (ie "to the best of my knowledge it's
already under a open-source license").

Of course, if it's a _big_ work with lots of original content, and you're 
unsure of exactly what the original author wanted to do with this, you 
obviously should _not_ sign off on it. But you knew that.

			Linus
