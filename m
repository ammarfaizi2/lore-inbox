Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263426AbUKZWNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbUKZWNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUKZWMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:12:31 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:54196
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S264029AbUKZV40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:56:26 -0500
Message-ID: <41A6166B.9050104@winischhofer.net>
Date: Thu, 25 Nov 2004 18:29:15 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SiS framebuffer driver update 1.7.17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resent after mail server failure at odsl]

Linus,
Andrew,

at

http://www.winischhofer.net/sis/sisfb_patch_2.6.10rc2.diff.gz

there is an update for sisfb, lifting it up to version 1.7.17.

It contains all changes done behind my back by other people (viro,
torvalds, adaplas) in the meantime. Furthermore,

- all remaining sparse warnings were fixed (mainly caused by the ROM code)

- problems with very old and brand new BIOSes from SiS were fixed,

- LCD setup was simplified, allowing more display modes than before,

- UMC/charter bridge type handling was added,

- a code clean-up was performed, the new FB_BLANK-flags were taken over,
VBLANK status info was corrected, etc.

Patch is against 2.6.10rc2 vanilla.


Signed-off-by: Thomas Winischhofer <thomas@winischhofer.net>


Thanks for listening,

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org


