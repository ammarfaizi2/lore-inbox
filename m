Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTBKBHM>; Mon, 10 Feb 2003 20:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTBKBHM>; Mon, 10 Feb 2003 20:07:12 -0500
Received: from dsl-213-023-060-099.arcor-ip.net ([213.23.60.99]:16103 "EHLO
	spot.lan") by vger.kernel.org with ESMTP id <S265400AbTBKBHL>;
	Mon, 10 Feb 2003 20:07:11 -0500
From: Oliver Feiler <kiza@gmx.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: Athlon adv speculative caching fix removed from 2.4.20?
Date: Tue, 11 Feb 2003 02:16:52 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200302102321.30549.kiza@gmx.net.suse.lists.linux.kernel> <p73fzqvbw6b.fsf@oldwotan.suse.de>
In-Reply-To: <p73fzqvbw6b.fsf@oldwotan.suse.de>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302110216.53111.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 February 2003 23:36, Andi Kleen wrote:
>
> The "long term" fix for it went in instead (arch/i386/mm/pageattr.c)
> The kernel is careful now to not create conflicting cache attributes
> for AGP and other mappings.  This makes the linux kernel x86
> conformant in this area.  It also increases performance on
> Athlon XP/MP because they can now use large pages in kernel space again.

Ah yes, indeed. I must have missed that. :)

Thanks for the quick answers everyone.

-Oliver

-- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx(pro).net)>
http://kiza.kcore.de/    <--    homepage
PGP-key      -->    /pgpkey.shtml
http://kiza.kcore.de/journal/

