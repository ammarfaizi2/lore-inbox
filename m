Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbVICH1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbVICH1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 03:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbVICH1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 03:27:45 -0400
Received: from quechua.inka.de ([193.197.184.2]:59307 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161173AbVICH1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 03:27:44 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050903070639.GC4593@ca-server1.us.oracle.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1EBSRB-0003lW-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 03 Sep 2005 09:27:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050903070639.GC4593@ca-server1.us.oracle.com> you wrote:
> for ocfs we have tons of production customers running many terabyte
> databases on a cfs. why ? because dealing with the raw disk froma number
> of nodes sucks. because nfs is pretty broken for a lot of stuff, there
> is no consistency across nodes when each machine nfs mounts a server
> partition. yes nfs can be used for things but cfs's are very useful for
> many things nfs just can't do. want a list ? 

Oh thats interesting, I never thought about putting data files (tablespaces)
in a clustered file system. Does that mean you can run supported RAC on
shared ocfs2 files and anybody is using that? Do you see this go away with
ASM?

Greetings
Bernd
