Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTFHL4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 07:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTFHL4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 07:56:47 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:36872 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261669AbTFHL4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 07:56:46 -0400
Subject: Re: 2.5.70-mm6
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030607151440.6982d8c6.akpm@digeo.com>
References: <20030607151440.6982d8c6.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055074197.584.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 08 Jun 2003 14:09:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-08 at 00:14, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm6/
> 
> . Numerous little fixes and additional work against additional patches.
> 
> . Waaay too many "cleanups".  These are taking significant amounts of
>   effort and it is time to start learning to live with dirty code.
> 
> . -mm kernels will be running at HZ=100 for a while.  This is because
>   the anticipatory scheduler's behaviour may be altered by the lower
>   resolution.  Some architectures continue to use 100Hz and we need the
>   testing coverage which x86 provides.

Testing it right now... It compiles nicely with gcc 3.3 (remember the
problems I had with snd-ymfpci when using gcc 3.2), boots and seems
functional.


