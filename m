Return-Path: <linux-kernel-owner+w=401wt.eu-S1752118AbWL2OIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWL2OIe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 09:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWL2OIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 09:08:34 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:42253 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbWL2OId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 09:08:33 -0500
Date: Fri, 29 Dec 2006 15:08:22 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-ID: <20061229140822.GH2062@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [2006-12-29 02:48]:
> Can anybody get corruption with this thing applied? It goes on top
> of plain v2.6.20-rc2.

It works for me now, both your testcase as well as an installation of
Debian on this ARM device.  I manually applied the patch to 2.6.19.

Thanks.
-- 
Martin Michlmayr
http://www.cyrius.com/
