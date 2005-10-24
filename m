Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVJXXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVJXXLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJXXLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:11:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8154 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751376AbVJXXLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:11:12 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <435D69B5.5000809@s5r6.in-berlin.de>
Date: Tue, 25 Oct 2005 01:09:41 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attachedPHYs)
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510241506130.7918@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0510241506130.7918@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.41) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> Stefan,
>   we are supposed to be on a 2-month release cycle, with all major 
> changes going in in the first two weeks of that cycle. This timeframe 
> doesn't leave you any noticable time to implement your steps seperatly 
> (and zero testing between them). as a result, in practice your proposal 
> amounts to a big-bang approach, and/or results in releases that are 
> known-broken.

Experimental branches of subsystems usually cannot (nor need to) be
bound to a release cycle.

> and while you suggest putting this in -mm, remember that the -mm kernel 
> needs to be useable so that people can test it, and it is on the same 
> schedule as the main kernel so again you can't have known-broken things 
> (of this scale) there either.

I assumed there would be a few unmaintained bits (of marginal "scale")
left which could not be updated, but it seems now that won't be the
case.
-- 
Stefan Richter
-=====-=-=-= =-=- ==--=
http://arcgraph.de/sr/
