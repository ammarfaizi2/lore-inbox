Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVK3Bxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVK3Bxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVK3Bxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:53:37 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:34451 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1750755AbVK3Bxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:53:37 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Reply-To: Ismail Donmez <ismail@uludag.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: linux-kernel@vger.kernel.org
Subject: MPlayer problems with kernel 2.6.15-rc3
Date: Wed, 30 Nov 2005 03:53:26 +0200
User-Agent: KMail/1.8.92
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511300353.26400.ismail@uludag.org.tr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When I try to change volume level in mplayer I got this using alsa output :

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'mplayer', page c12b9be0)
flags:0x80000414 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<c0140a3f>] bad_page+0x5f/0xa0
 [<c0141271>] free_hot_cold_page+0x41/0x120
 [<c014b187>] zap_pte_range+0x187/0x270
 [<c014b310>] unmap_page_range+0xa0/0x150
 [<c014b49f>] unmap_vmas+0xdf/0x1e0
 [<c014f375>] unmap_region+0x85/0x110
 [<c014f655>] do_munmap+0xc5/0x110
 [<c014f6db>] sys_munmap+0x3b/0x60
 [<c0102f3b>] sysenter_past_esp+0x54/0x79
Trying to fix it up, but a reboot is needed

Alsa version is 1.0.10 including driver package. Any idea whats going on?

P.S: I am not subscribed to list so please CC me in your replies.

Regards,
ismail
