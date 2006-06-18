Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWFRIQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWFRIQM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 04:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWFRIQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 04:16:12 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:29129 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932144AbWFRIQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 04:16:12 -0400
Date: Sun, 18 Jun 2006 04:13:15 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc6-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606180415_MC3-1-C2C5-AF79@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got around to downloading the broken-out 2.6.17-rc6-mm2 and when
I applied it a bunch of these came out:

  Applying patch documentation-ioctl-messtxt-start-tree-wide-ioctl-registry.patch
  missing header for unified diff at line 4854 of patch
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Applying patch post-halloween-doc.patch
  Applying patch kgdb-core-lite.patch
  missing header for unified diff at line 2614 of patch
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Applying patch lock-validator-special-locking-kgdb.patch
  Applying patch kgdb-core-lite-add-reboot-command.patch
  Applying patch kgdb-8250.patch
  Applying patch kgdb-8250-fix.patch
  Applying patch kgdb-netpoll_pass_skb_to_rx_hook.patch
  Applying patch kgdb-eth.patch
  Applying patch kgdb-i386-lite.patch
  Applying patch kgdb-cfi_annotations.patch
  missing header for unified diff at line 1423 of patch
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Seems mostly harmless, as the changes applied anyway, but those headers do
look strange: the '---' lines are missing a directory name:

  diff -puN Makefile~kgdb-cfi_annotations Makefile
  --- Makefile~kgdb-cfi_annotations       2006-06-09 15:18:45.000000000 -0700
  +++ devel-akpm/Makefile 2006-06-09 15:18:45.000000000 -0700

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
