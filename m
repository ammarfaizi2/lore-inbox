Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUCAB7s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbUCAB7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:59:48 -0500
Received: from hera.kernel.org ([63.209.29.2]:60588 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262221AbUCAB7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:59:46 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [SELINUX] Handle fuse binary mount data.
Date: Mon, 1 Mar 2004 01:59:22 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1u5dq$eiq$1@terminus.zytor.com>
References: <20040229150213.3ebd7ef9.akpm@osdl.org> <Xine.LNX.4.44.0402291938140.22392-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078106362 14939 63.209.29.3 (1 Mar 2004 01:59:22 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 1 Mar 2004 01:59:22 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Xine.LNX.4.44.0402291938140.22392-100000@thoron.boston.redhat.com>
By author:    James Morris <jmorris@redhat.com>
In newsgroup: linux.dev.kernel
> 
> It seems more like a property of the filesystem type: perhaps add 
> FS_BINARY_MOUNTDATA to fs_flags for such filesystems, per the patch below.
> 

That's the only sane way to do this.  I concur :)

	-hpa
