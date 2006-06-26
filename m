Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933080AbWFZWD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933080AbWFZWD6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933077AbWFZWD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:03:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:38366 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S933080AbWFZWD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:03:57 -0400
Subject: 2.6.17-mm2 & ecryptfs
From: Badari Pulavarty <pbadari@us.ibm.com>
To: mhalcrow@us.ibm.com, akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 15:05:59 -0700
Message-Id: <1151359559.32250.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure, if its already reported or not. 

2.6.17-mm2 vfs_statfs() takes a "dentry" instead of "sb".
ecryptfs seems to be broken :(

I get following warnings when I compile it.

fs/ecryptfs/super.c: In function `ecryptfs_statfs':
fs/ecryptfs/super.c:127: warning: passing arg 1 of `vfs_statfs' from
incompatible pointer type
fs/ecryptfs/super.c: At top level:
fs/ecryptfs/super.c:203: warning: initialization from incompatible
pointer type

Thanks,
Badari

