Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWFIXov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWFIXov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWFIXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:44:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:34782 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932594AbWFIXov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:44:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc
Date: Fri, 9 Jun 2006 16:44:46 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6d15e$j4l$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <bda6d13a0606091528h4e85265du8651818c73827b7d@mail.gmail.com> <e6ctsb$hij$1@terminus.zytor.com> <bda6d13a0606091613h3334facbrcb86dbb2de01b412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149896686 19606 127.0.0.1 (9 Jun 2006 23:44:46 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 9 Jun 2006 23:44:46 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bda6d13a0606091613h3334facbrcb86dbb2de01b412@mail.gmail.com>
By author:    "Joshua Hudson" <joshudson@gmail.com>
In newsgroup: linux.dev.kernel
> Should work if the following is true:
>    if pwd is /, mount / followed by ls . retunrs the contents of initramfs.

It does, and it does work as described.  Again, see the referenced code.

You can also fchdir() to the rootfs if you have a file descriptor to
any directory therein.

	-hpa
