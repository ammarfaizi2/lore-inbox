Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUKVAM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUKVAM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUKVAM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:12:28 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:37327 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261870AbUKVAL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:11:56 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] remove pointless <0 comparisons in drivers/video/fbmem.c
Date: Mon, 22 Nov 2004 08:11:43 +0800
User-Agent: KMail/1.5.4
Cc: Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0411220034040.3423@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0411220034040.3423@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411220811.43517.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 07:45, Jesper Juhl wrote:
> The "console" and "framebuffer" members of struct fb_con2fbmap are both
> unsigned, so it makes no sense to compare them for being <0. Patch to
> remove the pointless comparisons below.

Thanks.

Tony


