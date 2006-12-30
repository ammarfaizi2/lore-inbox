Return-Path: <linux-kernel-owner+w=401wt.eu-S1755121AbWL3AeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbWL3AeU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbWL3AeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:34:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36234 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106AbWL3AeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:34:19 -0500
Date: Fri, 29 Dec 2006 16:33:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-Id: <20061229163316.020fcda1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612291559540.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	<20061228114517.3315aee7.akpm@osdl.org>
	<Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
	<20061228.143815.41633302.davem@davemloft.net>
	<3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
	<Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
	<20061229141632.51c8c080.akpm@osdl.org>
	<Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
	<20061229155118.3feb0c17.akpm@osdl.org>
	<Pine.LNX.4.64.0612291559540.4473@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 16:11:44 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> > JBD implements physical block-based journalling, so it is 100% appropriate
> > that JBD deal with these disk blocks using their buffer_head
> > representation.
> 
> And as long as it does that, you just have to face the fact that it's 
> going to perform like crap, including what you call "extra" writes, and 
> what I call "deal with it".

It is quite tiresome to delete things which your interlocutor said and to
then restate them as if it were some sort of relevation.

> > Somewhat nastily, but as ext3 directories are metadata it is appropriate
> > that modifications to them be done in terms of buffer_heads (ie: blocks).
> 
> No. There is nothing "appropriate" about using buffer_heads for metadata. 

I said "modification".

> [stuff about directory reads elided]

