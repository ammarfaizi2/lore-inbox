Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTHGR2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbTHGR2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:28:05 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:56075 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269578AbTHGR2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:28:03 -0400
Date: Thu, 7 Aug 2003 18:28:01 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@suse.cz>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
 notification mecanism & PM
In-Reply-To: <1060267031.722.3.camel@gaston>
Message-ID: <Pine.LNX.4.44.0308071827240.13973-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For some reason, it seems that after we have switched to the suspend
> console, we race with the X server on accel engine, and on resume, the X
> server just crashes.

Are you shutting down the accel engine in the fbdev driver on suspend?


