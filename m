Return-Path: <linux-kernel-owner+w=401wt.eu-S1754861AbWL1PKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbWL1PKF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbWL1PKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:10:05 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:55370 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbWL1PKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:10:04 -0500
Message-ID: <4593DE31.4070401@yahoo.fr>
Date: Thu, 28 Dec 2006 16:09:37 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] mm: fix page_mkclean_one
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I set a qemu environment to test kernels: http://guichaz.free.fr/linux-bug/
I have corruption with every Fedora release kernel except the first, that is
2.4.22 works, but 2.6.5, 2.6.9, 2.6.11, 2.6.15 and 2.6.18-1.2798 exhibit 
some
corruption.

Command line to test:

qemu root_fs -snapshot -kernel FC-kernels/FC2-vmlinuz-2.6.5-1.358 -append 'rw root=/dev/hda'

I get this kind of corruption: 
http://guichaz.free.fr/linux-bug/corruption.png

-- 
Guillaume

