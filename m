Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUKUUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUKUUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKUUr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:47:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33031 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261710AbUKUUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:47:58 -0500
Date: Sun, 21 Nov 2004 20:47:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Message-ID: <20041121204752.A23300@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20041121153614.GR2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041121153614.GR2829@stusta.de>; from bunk@stusta.de on Sun, Nov 21, 2004 at 04:36:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 04:36:14PM +0100, Adrian Bunk wrote:
> The patch below ncludes the following cleanups for 
> drivers/video/cyber2000fb.c:
> - remove five EXPORT_SYMBOL'ed but completely unused functions
> - make some needlessly global code static

These are used by the video capture code which isn't merged, but is
used by people.  Rejected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
