Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUA2TdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUA2TdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:33:14 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48646 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266321AbUA2TdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:33:09 -0500
Date: Thu, 29 Jan 2004 19:33:07 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Guido Guenther <agx@sigxcpu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.2-rc2, rivafb]: GeForce4 440 Go 64M overflows fb_fix_screeninfo.id
In-Reply-To: <20040129192937.GI5681@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0401291932320.11251-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No way. Second part (riva/fbdev.c) is OK, but first part is wrong. fb_fix_screeninfo
> is part of ABI, and as such cannot be changed. No fb application is going to work
> on your system - try 'fbset -i' (unless you rebuilt fbset binary after doing this change).
> 
> You'll have to live with 'GeForce4-440-GO' name.

I applied the fbdev.c part but Petr is right. It would break userland.


