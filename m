Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbTDBTVu>; Wed, 2 Apr 2003 14:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263133AbTDBTVu>; Wed, 2 Apr 2003 14:21:50 -0500
Received: from ns.suse.de ([213.95.15.193]:23822 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263132AbTDBTVt>;
	Wed, 2 Apr 2003 14:21:49 -0500
Subject: Re: [PATCH][2.4.21-pre6] update x86_64 for kernel_thread change
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16011.14209.703212.772185@gargle.gargle.HOWL>
References: <16011.14209.703212.772185@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Apr 2003 21:33:14 +0200
Message-Id: <1049311995.10050.47.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 21:18, Mikael Pettersson wrote:
> Building an x86_64 kernel from 2.4.21-pre6 results in two linkage
> errors due to the recent kernel_thread to arch_kernel_thread name change.
> This patch updates x86_64 for that change.

You need more changes to fix the ptrace hole completely.

I have it mostly fixed in CVS (except this change), but Marcelo
currently only applies merges with several weeks delay so don't expect
it any time soon in official 2.4

-Andi
 


