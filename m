Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbUK0GXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUK0GXC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbUK0Do3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:44:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262684AbUKZTfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:50 -0500
Subject: Re: [2.6 patch] sstfb.c: make some code static
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ghozlane Toumi <gtoumi@laposte.net>, Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20041125153607.GC3537@stusta.de>
References: <20041121153646.GA2829@stusta.de>
	 <1101336587.2571.1.camel@localhost.localdomain>
	 <20041125153607.GC3537@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101401444.18354.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 16:50:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-25 at 15:36, Adrian Bunk wrote:
> The "ifdef crap" comes from the fact, that after making the functions 
> static, gcc warns if they are unused.

__attribute__ is your friend in that situation.

