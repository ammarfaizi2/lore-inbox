Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUAUXtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUAUXtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:49:18 -0500
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:26763
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S265940AbUAUXtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:49:17 -0500
Message-ID: <400F0F8C.8070900@winischhofer.net>
Date: Thu, 22 Jan 2004 00:47:24 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] sisfb update 2.6.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update for SiS framebuffer driver for 2.6.1 vanilla

Since it does not seem as if the fbdev stuff gets merged anytime soon, I 
made this patch for 2.6.1 vanilla.

I slightly lost track of current patch size policy, so please excuse me 
if this is beyond current limits.

Anyway, sisfb is simply broken in current 2.6.x. This patch updates 
sisfb to the current development version which no less than 11 months 
ahead of the version in the kernel.

Updated includes
- many fixes (duh)
- support for new chipsets (661, 741, 760)
- support for new video bridges (301C, 302ELV)
- removal of all offending fp code (as discussed earlier this month)
- a lot of code clean-up (which is the main reason for its size)

Patch is here: http://www.winischhofer.net/sis/sisfb_patch_2.6.1.diff.gz

If I may say "pretty please"...?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org
