Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266380AbUFQFk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUFQFk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266382AbUFQFk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:40:26 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:8974 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S266380AbUFQFkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:40:22 -0400
Date: Thu, 17 Jun 2004 07:39:57 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] color corruption (white becomes pink) in 16 bpp radeonfb
Message-ID: <20040617053957.GA14087@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040617053137.GA14869@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617053137.GA14869@middle.of.nowhere>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurriaan <thunder7@xs4all.nl>
Date: Thu, Jun 17, 2004 at 07:31:37AM +0200
> when used at 16 bpp, any white in the picture becomes pink when using
> fbi to view some .jpgs on the console.
> This didn't happen with 2.6.7-rc3-mm2.
> 
> It also affects the bootup-penguins: there's a black background, and
> only a pink silhouette inside.
> 
> Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-16@85
> 
Somehow, this seems linked to my other corruption problem. I just
rebooted 2.6.7 with David Eger's corruption-fix patch, and both fbi and
scrolling work fine @ 32 bpp. Perhaps 16 bpp itself is broken in some
way. However, 16bpp was working in 2.6.7-rc3-mm2.

Jurriaan
-- 
I do not want people to be agreeable, as it saves me the trouble of liking them.
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.09
