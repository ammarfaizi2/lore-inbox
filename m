Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUJPFGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUJPFGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268520AbUJPFGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:06:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:54248 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268488AbUJPFF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:05:59 -0400
Subject: Re: [PATCH] ppc64: Fix a typo in the code that reserves memory at
	boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1097902544.8963.5.camel@gaston>
References: <1097902544.8963.5.camel@gaston>
Content-Type: text/plain
Message-Id: <1097902973.9026.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 15:02:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 14:55, Benjamin Herrenschmidt wrote:
> Hi !
> 
> The code that marks memory regions as "reserved" early during boot
> has a typo (doing incorrect rounding of the top address) which can
> cause some areas to not be properly reserved. That may explain some
> cases of initrd corruption reported recently.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ok, ignore it and take Anton's one instead.

Ben.


