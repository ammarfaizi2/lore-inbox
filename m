Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266435AbUGJVY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUGJVY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUGJVY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:24:56 -0400
Received: from quechua.inka.de ([193.197.184.2]:20115 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266435AbUGJVYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:24:55 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040710184357.GA5014@taniwha.stupidest.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BjPL3-00076U-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 10 Jul 2004 23:24:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040710184357.GA5014@taniwha.stupidest.org> you wrote:
> No, that's not the case.  Normally when files are written the data
> isn't not flushed immediately, it sits in memory (the page-cache) for
> some (usually) small amount of time.

Does that mean, that closing a tempfile and then renaming  the file is not 
a reliable way to tell, that the data  is persited? I usually use a atomic
rename to have a point from which on I can tell if the data is complete
and persisted.

I thought close() has  fsync() semantics?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
