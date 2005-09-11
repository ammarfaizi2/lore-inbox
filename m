Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVIKSAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVIKSAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVIKSAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:00:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965007AbVIKSAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:00:01 -0400
Date: Sun, 11 Sep 2005 10:59:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miguel <frankpoole@terra.es>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PCI bug in 2.6.13
In-Reply-To: <20050911191532.7aa81b11.frankpoole@terra.es>
Message-ID: <Pine.LNX.4.58.0509111058450.3242@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
 <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es>
 <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org> <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
 <20050911030814.08cbe74c.frankpoole@terra.es> <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
 <20050911161058.481d1a75.frankpoole@terra.es> <Pine.LNX.4.58.0509110903050.4912@g5.osdl.org>
 <20050911191532.7aa81b11.frankpoole@terra.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Miguel wrote:
> 
> I have also tried that and it works too.
> 
> Thank you.

No, thank _you_. Disk corruption is a nasty nasty bug, and often very hard 
to track down. The fact that you could pin-point it so well and were 
willing to test different things out found a rather strange and subtle 
bug.

This deserves to go into the -stable tree.

		Linus
