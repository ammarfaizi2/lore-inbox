Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTIOMGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTIOMGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:06:04 -0400
Received: from catv-d5deb78c.bp13catv.broadband.hu ([213.222.183.140]:9606
	"EHLO dap.index") by vger.kernel.org with ESMTP id S261291AbTIOMGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:06:02 -0400
Subject: reproducable lockup on changing DMA state (2.4.22, cmd649)
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1063627245.493.97.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Sep 2003 14:00:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 changing DMA state (hdparm -d0/1) always lockups my system
(2.4.21/2.4.22) if another drive does heavy I/O on same channel in DMA
mode.. there's no problem if the another drive's in PIO mode or there's
no I/O..

 the biggest problem, that the kernel itself tries to change DMA state
if DMA timeout occurs and it's lockups the system too..  I've a machine
with 28 IDE disks on plain CMD649 controllers, and lots of lockups
happens when a disk going to die soon.. :(


# kernel 2.4.22
# cmd649 ctrl
# maxtor, samsung, quantum disks, nevermind


-- 
  DaP
