Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVCCSHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVCCSHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVCCSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:04:55 -0500
Received: from av1-1-sn1.fre.skanova.net ([81.228.11.107]:39627 "EHLO
	av1-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262054AbVCCSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:04:33 -0500
Date: Thu, 3 Mar 2005 19:04:27 +0100
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 hda: dma_timer_expiry: dma status == 0x61
Message-Id: <20050303190427.5dd1a906.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Out of the blue came a screen freeze. Opera browser froze, window
manager froze (not X or mouse) but gkrellm system monitor was alive and
showing no irregular activity. The freeze lasted less than a minute.
It resembled nothing I've ever seen before. Kernel log has the following
entry:

Mar  3 18:03:01 loke kernel: hda: dma_timer_expiry: dma status == 0x61
Mar  3 18:03:11 loke kernel: hda: DMA timeout error
Mar  3 18:03:11 loke kernel: hda: dma timeout error: status=0x58 
{ DriveReady SeekComplete DataRequest }
Mar  3 18:03:11 loke kernel:
Mar  3 18:03:11 loke kernel: ide: failed opcode was: unknown

My drives have thir SMART regularly checked by
smartmontools(.sourceforge.net) and doing a manual run right after this
freeze showed everything to be OK.

Mvh
Mats Johannesson
--
