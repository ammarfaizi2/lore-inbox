Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUD3Wdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUD3Wdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUD3Wdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:33:43 -0400
Received: from ANice-106-1-12-193.w81-49.abo.wanadoo.fr ([81.49.243.193]:9127
	"EHLO mail.mayle.org") by vger.kernel.org with ESMTP
	id S261817AbUD3Wde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:33:34 -0400
Subject: Re: [PATCH] Framebuffer Layer - Radeonfb, kernel 2.6.5
From: Douglas Mayle <douglas@mayle.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <409295D1.6070609@techsource.com>
References: <1083340507.8830.16.camel@doug64.sophia.metrixsystems.com>
	 <409295D1.6070609@techsource.com>
Content-Type: text/plain
Message-Id: <1083364411.5868.3.camel@doug64.mayle.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 01 May 2004 00:33:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you specify a resolution different from what EDID reports, what you 
> get on screen is the resolution reported by EDID physically, but 
> virtually the resolution requested.  That is, if I ask for 1280x1024, 
> but EDID says 1024x768, I see the upper left 1024x768 of the 1280x1024 
> screen that the console is being displayed on.

I'm not sure I'd call that a bug.  You've set the resolution
specifically, and the driver does it's best to give you what you've
requested.

