Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVCFNbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVCFNbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 08:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVCFNbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 08:31:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:55276 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261396AbVCFNbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 08:31:44 -0500
X-Authenticated: #20450766
Date: Sun, 6 Mar 2005 14:30:47 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: jim.hague@acm.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
In-Reply-To: <Pine.LNX.4.60.0503061047590.3733@poirot.grange>
Message-ID: <Pine.LNX.4.60.0503061427250.2997@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
 <Pine.LNX.4.60.0503061047590.3733@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005, Guennadi Liakhovetski wrote:

> I wasn't quite correct in my report yesterday. Replacing pm2fb.c from 
> 2.6.11 with 2.6.10 fixes only one problem - the font becomes white again 
> and penguin images get fixed. But switching from X to vt still doesn't 
> work. It works under 2.6.10-rc2.

Ok. Reverting also fbcon.[hc] to 2.6.10 fixes the X-switching problem too.

Thanks
Guennadi
---
Guennadi Liakhovetski

