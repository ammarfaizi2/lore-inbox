Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVCFJxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVCFJxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 04:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVCFJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 04:53:37 -0500
Received: from imap.gmx.net ([213.165.64.20]:5327 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261340AbVCFJxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 04:53:32 -0500
X-Authenticated: #20450766
Date: Sun, 6 Mar 2005 10:52:49 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: jim.hague@acm.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
In-Reply-To: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
Message-ID: <Pine.LNX.4.60.0503061047590.3733@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't quite correct in my report yesterday. Replacing pm2fb.c from 
2.6.11 with 2.6.10 fixes only one problem - the font becomes white again 
and penguin images get fixed. But switching from X to vt still doesn't 
work. It works under 2.6.10-rc2. The new config is based on oldconfig with 
almost all new defaults. Nothing fb-related, AFAICT. I'll try to revert 
some other files in drivers/video later today, unless someone has a better 
idea.

Thanks
Guennadi
---
Guennadi Liakhovetski

