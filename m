Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWAYC6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWAYC6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 21:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWAYC63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 21:58:29 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:23349 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750978AbWAYC63 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 21:58:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G5h4LNDtSk/wNJtd05XQe43wHuGTRzCw49sae46Css5gkYG08Yp6aadGqaVH3rF45oE+ys4QVz2T52tXTpDXbQsEx+QgN7+ceYy4C2ASr3DpgV1OiphCPFEU8W9pjBralPm1sISiES+ia3HKhJ6exSXCGHk+14NHwnJz488qBBE=
Message-ID: <bda6d13a0601241858g260b915bs5370d34ac90321de@mail.gmail.com>
Date: Tue, 24 Jan 2006 18:58:28 -0800
From: Joshua Hudson <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Block device API
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a kernel filesystem driver. I have found plenty of
documentation on
how to communicate between the VFS and the filesystem driver, but nothing
on how to communicate between the block device and the filesystem driver.

I found sb_bread() but there is no corrisponding sb_bwrite().
I presume that if ((struct superblock *)s) -> bdev is the block
device handle, but I cannot find the read/write pair of functions.
