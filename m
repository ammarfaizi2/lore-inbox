Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFMV0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFMV0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFMV0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:26:02 -0400
Received: from colin.muc.de ([193.149.48.1]:19469 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261400AbVFMVXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:23:17 -0400
Date: 13 Jun 2005 23:23:14 +0200
Date: Mon, 13 Jun 2005 23:23:14 +0200
From: Andi Kleen <ak@muc.de>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Tracking a bug in x86-64
Message-ID: <20050613212314.GC86745@muc.de>
References: <200506132259.22151.bonganilinux@mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506132259.22151.bonganilinux@mweb.co.za>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 10:59:21PM +0200, Bongani Hlope wrote:
> Hi Andrew and Andi
> 
> I've been trying to track dow an bug that causes my userspace applications to 
> randomly segfault. I've tracked it down to 2.6.11-mm4 (I'm not sure about mm[1-3]).  
> The bug does not exist in the 2.6.11 kernel. The 2.6.12-rc1 kernel has the bug. The bug 
> is easly triggered by compiling KDE or the kernel using make -j4
> 
> The following kernels also have the bug: 2.6.12rc1-mm4, 2.6.12rc3-mm2,  2.6.12rc3-mm3
> 2.6.12rc4-mm2, 2.6.12rc6-mm1 and 2.6.12rc6. I'm busy downloading 2.6.11-mm[1-3] to see
> when it was introduced, because it seems to have been merged to mailine from the -mm series.

Can you track it down to an individual patch or a list of patches? 

I would stay on mainline if you can reproduce it there 
since it has less "noise" than -mm. 

-Andi
