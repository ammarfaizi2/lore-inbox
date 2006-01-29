Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWA2ITM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWA2ITM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWA2ITL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:19:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750796AbWA2ITK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:19:10 -0500
Date: Sun, 29 Jan 2006 00:18:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       benh@kernel.crashing.org, linux-kernel@hansmi.ch
Subject: Re: [PATCH] fbdev: Fix usage of blank value passed to fb_blank
Message-Id: <20060129001832.4fe6fd7f.akpm@osdl.org>
In-Reply-To: <43DC25EB.1040005@gmail.com>
References: <20060127231314.GA28324@hansmi.ch>
	<20060127.204645.96477793.davem@davemloft.net>
	<43DB0839.6010703@gmail.com>
	<200601282106.21664.ioe-lkml@rameria.de>
	<43DC25EB.1040005@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
> Unfortunately, this may cause some userland breakage.  X should work.
>  However, some apps may have been developed that uses the FB_BLANK constants
>  (DirectFB?).  In these cases, they'll get a deeper blank level instead, so it
>  probably won't affect them significantly.  A follow up patch that hides the 
>  FB_BLANK constants may be worthwhile.

Would prefer to avoid any userland breakage.  Is this followup patch
happening?
