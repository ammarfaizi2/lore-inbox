Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWBIBPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWBIBPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422753AbWBIBPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:15:53 -0500
Received: from quechua.inka.de ([193.197.184.2]:23209 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1422752AbWBIBPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:15:52 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: file system question
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <ef2d59350602081613y5ba8c264j45a64363360bd58e@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F70PW-0005Kw-00@calista.inka.de>
Date: Thu, 09 Feb 2006 02:15:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kapil a <kapilann@gmail.com> wrote:
> When i did some debugging i found that filldir which is suppose to
> fill the dirent with the directory entries does its job. My filesystem
> currently has only one inode with one block of data where i have a
> ".", ".." and "test" written into it.
> 
> The problem is it does not go further to do some of the other calls as
> in a mountpoint in ext2 file system.

in that case ls is missing something, maybe a count, a size, filetype,
permission... why dont you debug ls to see where it is exiting? I mean if
you write kernel mode code one could expect that you can step through a user
mode tool?


Gruss
Bernd
