Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWIDAQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWIDAQP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 20:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWIDAQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 20:16:15 -0400
Received: from quechua.inka.de ([193.197.184.2]:1455 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750724AbWIDAQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 20:16:14 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <44FB5AAD.7020307@perkel.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GK28K-0003wd-00@calista.eckenfels.net>
Date: Mon, 04 Sep 2006 02:16:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <44FB5AAD.7020307@perkel.com> you wrote:
> If I have two drives and I want swap to be fast if I allocate swap spam 
> on both drives does it break up the load between them? Or would it run 
> faster if I did a Raid 0 swap?

if you set up two swap partitions with the same prio, it will distribute the
access, you dont need striping for that. (However with striping you can a
bit better control the stripe size).

Of course you should not plan for swapping, it is just slow...

Gruss
Bernd

-- 
VGER BF report: H 0.224635
