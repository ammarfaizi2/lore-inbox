Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUAKKox (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 05:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUAKKox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 05:44:53 -0500
Received: from mx02.qsc.de ([213.148.130.14]:39298 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265833AbUAKKow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 05:44:52 -0500
Message-ID: <40012825.60405@trash.net>
Date: Sun, 11 Jan 2004 11:40:37 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: Wilmer van der Gaast <lintux@lintux.cx>, linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.4.23 masquerading broken?
References: <20031202165653.GJ615@gaast.net> <3FCCCB02.5070203@trash.net> <20040110215954.GC20706@sunbeam.de.gnumonks.org>
In-Reply-To: <20040110215954.GC20706@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:

>This seems to be the same as 
>http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0465.html
>and https://bugzilla.netfilter.org/cgi-bin/bugzilla/show_bug.cgi?id=144
>
>I've committed the proposed fix (from #144) into patch-o-matic/pending.
>
>Comments?
>  
>

I don't know if reverting to 2.4.22 is the correct fix, the change was made after this
mail from Alexey http://marc.theaimsgroup.com/?l=linux-net&m=105915597804604&w=2 ,
he states that giving out ifindex is a bug. I don't understand the problem yet but I'm
looking into it.

BTW: Why do we need a route lookup at all ? Couldn't we just use the first address on 
dev->in_dev->ifa_list ?

Best regards,
Patrick


