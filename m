Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTDVC5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTDVC5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:57:19 -0400
Received: from web40810.mail.yahoo.com ([66.218.78.187]:57614 "HELO
	web40810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262849AbTDVC5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:57:18 -0400
Message-ID: <20030422030917.12838.qmail@web40810.mail.yahoo.com>
Date: Mon, 21 Apr 2003 20:09:17 -0700 (PDT)
From: gordon anderson <gordonski_anderson@yahoo.com>
Subject: 2.5.68 build - modules_install - depmod probs - 815fb / zlib - help
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry if wrong forum!

Building 2.5.68 kernel with intel815 framebuffer support &
crypto options.

make modules_install gives -

depmod: *** Unresolved symbols in
/lib/modules/2.5.68/kernel/crypto/deflate.ko
depmod:         zlib_inflateInit2_
depmod:         zlib_inflate
depmod:         zlib_inflate_workspacesize
depmod:         zlib_deflateInit2_
depmod:         zlib_deflate_workspacesize
depmod:         zlib_deflate
depmod:         zlib_inflateReset
depmod:         zlib_deflateReset
depmod: *** Unresolved symbols in
/lib/modules/2.5.68/kernel/drivers/video/console/fbcon.ko
depmod:         find_font
depmod:         get_default_font
depmod: *** Unresolved symbols in
/lib/modules/2.5.68/kernel/drivers/video/i810/i810fb.ko
depmod:         restore_vga
depmod:         save_vga
depmod: *** Unresolved symbols in
/lib/modules/2.5.68/kernel/drivers/video/vga16fb.ko
depmod:         restore_vga
depmod:         save_vga

Any ideas/workaround.

gord.

__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com
