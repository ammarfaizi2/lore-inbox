Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbTHGRXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270218AbTHGRXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:23:17 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:48907 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270094AbTHGRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:23:16 -0400
Date: Thu, 7 Aug 2003 18:23:12 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@suse.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
 notification mecanism & PM
In-Reply-To: <20030807100309.GB166@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308071822270.13973-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I believe solution to this is simple: always switch to kernel-owned
> console during suspend. (swsusp does it, there's patch for S3 to do
> the same). That way, Xfree (or qtopia or whoever) should clean up
> after themselves and leave the console to the kernel. (See
> kernel/power/console.c)

Not very helpful on embedded systems that use the framebuffer without the 
VT console. 

