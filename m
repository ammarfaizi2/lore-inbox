Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWEPAPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWEPAPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWEPAPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 20:15:04 -0400
Received: from mailfe10.swipnet.se ([212.247.155.33]:55974 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750868AbWEPAPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 20:15:03 -0400
X-T2-Posting-ID: 6GBUGr3zkYYCG9T7x2Ik0yQrRuFhZLxyP+8apJj5Sjg=
X-Cloudmark-Score: 0.000000 []
From: lgouv@tele2.be
Date: Tue, 16 May 2006 02:15:01 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4-mm1 panic on boot
Message-ID: <20060516001501.GA7528@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just upgraded from rc3-mm4.
Panic on boot with this message (copied by hand ):
	kinit:do_mount
	kinit: name_to_dev_t(/dev/hda8) = dev (0,0)
	kinit:rot_dev = dev (0,0)
	kinit root_dev = dev (0,0)
	kinit trying to mount /dev/root on /root
	...........
/dev/hda8 is my root partition but I suppose dev (0,0) is the first
partition on hda which is FAT.
I tried vanilla rc4 with the same result.


