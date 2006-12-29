Return-Path: <linux-kernel-owner+w=401wt.eu-S1753027AbWL2NIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbWL2NIQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 08:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbWL2NIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 08:08:16 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:65210 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbWL2NIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 08:08:15 -0500
Message-ID: <45951333.5070205@fatbob.nu>
Date: Fri, 29 Dec 2006 14:08:03 +0100
From: Martin Johansson <martin@fatbob.nu>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl, tbm@cyrius.com,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>[...] 
> The patch is mostly a comment. The "real" meat of it is actually just a 
> few lines.
> 
> Can anybody get corruption with this thing applied? It goes on top of 
> plain v2.6.20-rc2. 

No corruption with the testcase here. Will check with rtorrent too later 
today but I suppose it will work just fine.
Nice work! It has been interesting (and educating) to follow this 
bug-hunt :)

/Martin
