Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWFJAYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWFJAYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWFJAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:24:20 -0400
Received: from quechua.inka.de ([193.197.184.2]:34461 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932610AbWFJAYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:24:19 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
Subject: Re: [RFC]  Slimming down struct inode
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <E1Foqjw-00010e-Ln@candygram.thunk.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1ForGz-0005o8-00@calista.eckenfels.net>
Date: Sat, 10 Jun 2006 02:24:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> wrote:
> 3) Move i_pipe, i_bdev, and i_cdev into a union.  An inode cannot
>    simultaneously be a pipe, block device, and character device at the
>    same time.

Mabe a regular file inode atribute can be put in that union, too?

Gruss
Bernd


