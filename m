Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbTF2Lb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 07:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbTF2Lb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 07:31:27 -0400
Received: from [195.208.223.239] ([195.208.223.239]:1664 "EHLO pls.park.msu.ru")
	by vger.kernel.org with ESMTP id S265640AbTF2Lb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 07:31:26 -0400
Date: Sun, 29 Jun 2003 15:45:57 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "T. Weyergraf" <kirk@colinet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 on alpha/smp build failure
Message-ID: <20030629154557.A694@pls.park.msu.ru>
References: <kirk-1030628112813.A0111034@hydra.colinet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <kirk-1030628112813.A0111034@hydra.colinet.de>; from kirk@colinet.de on Sat, Jun 28, 2003 at 11:28:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 11:28:13AM +0200, T. Weyergraf wrote:
> ld: arch/alpha/kernel/built-in.o: !samegp reloc against symbol without .prologue: memset
> make[1]: *** [vmlinux] Error 1
...
> Any ideas ?  ( what puzzles me, is that i am apparently the only
> alpha user with that problem... )

No, I've seen this too. Fixed in current BK.

Ivan.
