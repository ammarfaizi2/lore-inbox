Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVCGQhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVCGQhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVCGQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:37:20 -0500
Received: from mail.logixonline.com ([216.201.128.36]:36358 "EHLO
	mail.logixonline.com") by vger.kernel.org with ESMTP
	id S261846AbVCGQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:37:15 -0500
Date: Mon, 7 Mar 2005 10:37:11 -0600
From: Chuck Campbell <campbell@accelinc.com>
To: linux-kernel@vger.kernel.org
Cc: campbell@accelinc.com
Subject: NFS problem in 2.4.21 (RHEL ES 3 upd 2)
Message-ID: <20050307163711.GB11949@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just built a cluster of dual Opteron boxes, running RHEL 3 update 2
x86_64 OS.

I have problems creating files larger than 2GB on an NFS mounted filesystem.

Creating files larger than this on local filesystems is no problem.

Filesystems are all ext3.  Coreutils is version 4.5.3-26.

I can't find any "largefile" flags, etc in nfs, nfsd, rpc.nfsd, rpc.mountd,
exports or exportfs man pages.

Any pointers to other docs, etc. greatly appreciated.

thanks,
-chuck
