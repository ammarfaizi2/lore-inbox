Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUB2XmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbUB2XmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 18:42:09 -0500
Received: from hera.kernel.org ([63.209.29.2]:53672 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262180AbUB2XmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 18:42:07 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [SELINUX] Handle fuse binary mount data.
Date: Sun, 29 Feb 2004 23:41:43 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1ttbn$dd7$1@terminus.zytor.com>
References: <Xine.LNX.4.44.0402291637360.22151-100000@thoron.boston.redhat.com> <20040229215542.A31786@infradead.org> <20040229150213.3ebd7ef9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078098103 13736 63.209.29.3 (29 Feb 2004 23:41:43 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 29 Feb 2004 23:41:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040229150213.3ebd7ef9.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
> 
> Yes, it's rather awkward.
> 
> Could we do something such as passing a new mount flag in from userspace? 
> Add a new flag alongside MS_SYNCHRONOUS, MS_REMOUNT and friends?
> 

IMNSHO it should be a flag exported by any registered filesystem.

	-hpa
