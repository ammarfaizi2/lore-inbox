Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUBPXgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUBPXgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:36:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:48289 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265952AbUBPXgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:36:11 -0500
Subject: Re: fbdev cursor part 1.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0402162221001.21833-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402162221001.21833-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1076974526.1046.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 10:35:27 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-17 at 09:26, James Simmons wrote:
> Hi!
> 
>    I broke up the cursor patch. This patch creates a seperate cursor 
> image drawing region and regular drawing region. It does not break any 
> drivers to my knowledge. I posted it anyways for people to test it. The 
> patch is against 2.6.3-rc3. Please try.

Andrew, that one seem to work fine for me, been hammered for some time
in the fbdev tree. It should go to -mm for a while imho so we get more
broader testing, and eventually in 2.6.4

Ben.


