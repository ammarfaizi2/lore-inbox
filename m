Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWFJFcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWFJFcn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWFJFcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:32:43 -0400
Received: from quechua.inka.de ([193.197.184.2]:53163 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932401AbWFJFcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:32:42 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: How long can an inode structure reside in the inode_cache?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fow57-0000Sh-00@calista.eckenfels.net>
Date: Sat, 10 Jun 2006 07:32:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao <uszhaoxin@gmail.com> wrote:
> put into the inode_cache, but when will this inode be free and removed
> from the inode_cache? after this file is closed? If so, this seems to
> be inefficient.

What do you consider inefficient? that is cached too long or too short? Open
files wont be pruned, closed files when there is memory pressure. Thats
quite efficient.

Gruss
Bernd
