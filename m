Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUIPXcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUIPXcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUIPX1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:27:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47836 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268105AbUIPXWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:22:22 -0400
Date: Fri, 17 Sep 2004 00:21:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs in latest BK
In-Reply-To: <20040916190633.GG2825@krispykreme>
Message-ID: <Pine.LNX.4.44.0409170019120.2925-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Anton Blanchard wrote:
> 
> I just gave BK a try on my ppc32 laptop and tmpfs looks to be playing up:
> 
> # mount -t tmpfs none /mnt
> # ls /mnt
> ls: mnt: Not a directory

Bizarre.
You think you've caught me indulging in silent semantic changes?

> Does this ring any bells? :)

It's alarming, but I don't recognize the bells.
I blame the removal of SLAB_HWCACHE_ALIGN, that I copied from you ;)

Seriously, it's fine for me on i386, has been in -mm for ten days,
and I don't see what's architecture dependent about the changes.

Nothing springs to my mind: may I ask you (or any others who find the
same?) to delve into it?  If I have any ideas later on, I'll mail again.

Thanks - and sorry for this late and unhelpful response,
Hugh

