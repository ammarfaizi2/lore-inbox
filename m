Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUHLXzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUHLXzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268895AbUHLXzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:55:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:33244 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S268894AbUHLXzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:55:08 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: New concept of ext3 disk checks
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040812223907.GA7720@thunk.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BvPPW-0005fA-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 13 Aug 2004 01:55:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040812223907.GA7720@thunk.org> you wrote:
> 1) Create a clean, read-only snapshot of an ext3 filesystem using
> device mapper.

Speaking of clean, is there something like the XFS freeze for ext? I know
freezing XFS is pretty dangerous (swap, temp, root) so I think it is not
useable on all devices anyway.

> Tell you what --- if someone is willing to put the time into
> developing such a script, I'll include it in the contrib section of
> e2fsprogs.

I did that for XFS some time ago, but the parameters where all hardcoded. I
used the freeze command. Do you think one can skip that for ext3?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
