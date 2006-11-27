Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758302AbWK0PjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302AbWK0PjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758303AbWK0PjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:39:05 -0500
Received: from ns2.suse.de ([195.135.220.15]:18565 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758302AbWK0PjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:39:03 -0500
From: Andi Kleen <ak@suse.de>
To: Amul Shah <amul.shah@unisys.com>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Mon, 27 Nov 2006 16:38:54 +0100
User-Agent: KMail/1.9.5
Cc: Eric Dumazet <dada1@cosmosbay.com>, LKML <linux-kernel@vger.kernel.org>
References: <1163627312.3553.199.camel@ustr-linux-shaha1.unisys.com> <200611271123.11649.dada1@cosmosbay.com> <1164641576.3227.12.camel@ustr-linux-shaha1.unisys.com>
In-Reply-To: <1164641576.3227.12.camel@ustr-linux-shaha1.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271638.54559.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I believe that this problem is related to a new patch that enhances the
> fake NUMA code (see http://article.gmane.org/gmane.linux.kernel/469457).

I haven't got these patches applied, so that's unlikely.

BTW if you resubmit make sure to keep the #ifdefs I added -- your original
version didn't compile without CONFIG_NUMA

Does it work for you when you boot the kernel on a non NUMA system 
(like a normal small Intel platform)? 

-Andi
