Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbULMIgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbULMIgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 03:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbULMIgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 03:36:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45774 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262077AbULMIf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 03:35:59 -0500
Date: Mon, 13 Dec 2004 09:35:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Heath <chris@heathens.co.nz>
cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Improved console UTF-8 support for the Linux kernel?
In-Reply-To: <1102920623.30543.1820.camel@linux.heathens.co.nz>
Message-ID: <Pine.LNX.4.61.0412130933510.2394@yvahk01.tjqt.qr>
References: <1102920623.30543.1820.camel@linux.heathens.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Logically, keyboard input and console display are separated in the
>kernel. When you switch in and out of Unicode mode you have to switch

But they get agglumerated when it comes to ttys.

>As you have already figured out, Suse is using this patch in their
>distribution, so I figure it has had pretty wide testing already.

They actually don't, as of KOTD 20041202. Patching the tree with the three 
-CDH1 patches gave no fatal rejects (except a few linenoise), so the patches 
are not in there ATM.

>I have a couple of other patches on my website, which I am happy to
>submit (or you are welcome to take), but this is the simplest and the
>most popular.
>

Jan Engelhardt
-- 
ENOSPC
