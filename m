Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWEFR32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWEFR32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWEFR32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 13:29:28 -0400
Received: from quechua.inka.de ([193.197.184.2]:55959 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750756AbWEFR31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 13:29:27 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060506164808.GY15445@waste.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FcQar-0002Wo-00@calista.inka.de>
Date: Sat, 06 May 2006 19:29:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>> So I would much prefer to see the entropy sampling stay in its current
>> location, since people using real-time deserve real randomness too.
>> (In fact, some of them may have a **much** stronger need for it.  :-)
> 
> This is the point that bothers me. It's one thing to optimistically
> mix network samples (or any other convenient source) into the entropy
> pool. I'm all for that. The more, the better.

Isnt it possible to use timestamps on the received packages. So you get the
indeterministic timing from interrupt context and can process it in a less
hot path. Also the timestamps are helpfull for other stuff, also.

Gruss
Bernd
