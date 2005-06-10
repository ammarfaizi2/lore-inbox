Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVFJNXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFJNXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVFJNXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:23:41 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1550 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP id S261594AbVFJNXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:23:34 -0400
Date: Fri, 10 Jun 2005 15:23:31 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net, benh@kernel.crashing.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: new framebuffer fonts + updated 12x22 font available
Message-ID: <20050610132331.GA8643@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've spent my offline-vacation on improving the fonts for use with the
framebuffer.

I've added all the characters marked 'FIXME' in the sun12x22 font and
created a 10x18 font (based on the sun12x22 font) and a 7x14 font (based
on the vga8x16 font).

The total patch is about 300 KiB, so I won't attach it here. 

As maintainership of the fonts is unknown to me, I'm posting this to
lkml, fb-devel, Andrew and some choice fb developers.

This patch is non-intrusive, no options are enabled by default so most
users won't notice a thing.

I am placing my changes under the GPL, however, I've not seen any
copyright notices on the sun12x22 font and the vga8x16 font which I
derived my new fonts from so I don't know what the copyright status is.

The patch is available at

http://www.xs4all.nl/~thunder7/fonts_7x14_10x18_12x22.diff

I would appreciate inclusion, of course, or constructive comments.

Thanks,
Jurriaan
-- 
It was not a compliment, but there was praise in it, if one knew how to look.
	Michelle West - Sea of Sorrows
Debian (Unstable) GNU/Linux 2.6.12-rc4-mm2 2x6017 bogomips load 0.02
