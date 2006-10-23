Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751947AbWJWMxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWJWMxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWJWMxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:53:51 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52429 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751947AbWJWMxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:53:50 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061023125318.2C4D983026@kleikamp.austin.ibm.com>
Date: Mon, 23 Oct 2006 07:53:18 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/jfs_imap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

through these ChangeSets:

Commit: 8f6cff98477edbcd8ae4976734ba7edd07bdd244 
Author: Dave Kleikamp <shaggy@austin.ibm.com> Fri, 13 Oct 2006 12:42:36 -0500 

    JFS: pageno needs to be long
    
    diRead and diWrite are representing the page number as an unsigned int.
    This causes file system corruption on volumes larger than 16TB.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

