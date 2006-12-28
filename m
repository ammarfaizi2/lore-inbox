Return-Path: <linux-kernel-owner+w=401wt.eu-S1754885AbWL1QNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbWL1QNz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbWL1QNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:13:55 -0500
Received: from mailout.surf-town.net ([212.97.132.199]:33427 "EHLO
	mailout.surf-town.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbWL1QNy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:13:54 -0500
X-Greylist: delayed 1399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 11:13:54 EST
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "martin@fatbob.nu" <martin@fatbob.nu>
To: Linus Torvalds <torvalds@osdl.org>, Guillaume Chazarain <guichaz@yahoo.fr>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Reply-To: martin@fatbob.nu
X-Origin: 194.17.32.1
Date: Thu, 28 Dec 2006 16:50:23 +0100
Cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Uidl: 4593DE31.4070401@yahoo.fr
X-Mailer: AtMail 4.4 - 194.17.32.1 - martin@fatbob.nu
Message-Id: <20061228155023.F10B4168004@webmail2.surf-town.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu Dec 28 15:09 , Guillaume Chazarain sent:

>I set a qemu environment to test kernels: http://guichaz.free.fr/linux-bug/
>I have corruption with every Fedora release kernel except the first, that is
>2.4.22 works, but 2.6.5, 2.6.9, 2.6.11, 2.6.15 and 2.6.18-1.2798 exhibit 
>some corruption.

Confirm that I see corruption with Fedora kernel 2.6.18-1.2239.fc5:

...
Chunk 142969 corrupted (0-1459)  (2580-4039)
Expected 121, got 0
Written as (89632)127652(124721)
Chunk 142976 corrupted (0-1459)  (512-1971)
Expected 128, got 0
Written as (121734)128324(108589)
Checking chunk 143639/143640 (99%)
$ uname -a
Linux 2.6.18-1.2239.fc5 #1 Fri Nov 10 13:04:06 EST 2006 i686 athlon i386 GNU/Linux

/Martin
