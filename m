Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVAaKIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVAaKIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVAaKIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:08:36 -0500
Received: from fe-6c.inet.it ([213.92.5.112]:51137 "EHLO fe-6c.inet.it")
	by vger.kernel.org with ESMTP id S261800AbVAaKIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:08:35 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.11-rc[1,2]-mmX scsi cdrom problem, 2.6.10-mm2 ok
Date: Mon, 31 Jan 2005 11:08:19 +0100
User-Agent: KMail/1.7.91
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>
References: <200501310034.32005.cova@ferrara.linux.it> <20050131080021.GA9446@suse.de>
In-Reply-To: <20050131080021.GA9446@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501311108.19593.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 09:00, lunedì 31 gennaio 2005, Jens Axboe ha scritto:
>
> > At this point k3b is stuck in D stat, needs reboot.
>
> The most likely suspect is the REQ_BLOCK_PC scsi changes. Can you try
> 2.6.11-rc2-mm1 with bk-scsi backed out? (attached)

just tried, right guess :)
backing out that patch the problem disappears.
Let me know if you need to narrow further that issue.

Thanks :)


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
