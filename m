Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVIIL5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVIIL5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVIIL5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:57:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:12212 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751353AbVIIL5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:57:34 -0400
From: Andi Kleen <ak@suse.de>
To: trond.myklebust@fys.uio.no
Subject: do_vfs_lock: VFS is out of sync with lock manager!
Date: Fri, 9 Sep 2005 13:57:20 +0200
User-Agent: KMail/1.8
Cc: okir@suse.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091357.20675.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



FYI

I ran the LTP September release's runltpquick.sh script over a NFS mount 
(talking to a 2.6.11 knfsd)  on 2.6.13 and this produced lots of

do_vfs_lock: VFS is out of sync with lock manager!

messages in the kernel lock. The machine also had NFS root.

-Andi
