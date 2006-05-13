Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWEMDhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWEMDhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWEMDhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:37:42 -0400
Received: from c-67-177-57-20.hsd1.co.comcast.net ([67.177.57.20]:38643 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1751118AbWEMDhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:37:41 -0400
Date: Fri, 12 May 2006 21:37:42 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set constitutes the 0.1.7 release of the eCryptfs
cryptographic filesystem:

http://ecryptfs.sourceforge.net/

It includes numerous updates based on comments on the 0.1.6 submission
made on May 4th. The only functional change worth noting is the
removal of the unnecessary second read in ecryptfs_get1page() and
ecryptfs_do_readpage().

This patch set was produced and tested against the 2.6.17-rc3-mm1
release of the kernel.

Thanks,
Phillip
