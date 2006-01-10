Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWAJTBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWAJTBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAJTBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:01:55 -0500
Received: from rtr.ca ([64.26.128.89]:32406 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751189AbWAJTBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:01:51 -0500
Message-ID: <43C4049E.6020105@rtr.ca>
Date: Tue, 10 Jan 2006 14:01:50 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>	 <20060110133728.GB3389@suse.de>	 <Pine.LNX.4.63.0601100840400.9511@winds.org>	 <20060110143931.GM3389@suse.de>	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>	 <43C3F986.4090209@mbligh.org>	 <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org> <1136919312.2557.77.camel@localhost.localdomain>
In-Reply-To: <1136919312.2557.77.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>
> It actually "just works".  We have a 16GB machine that gets a lot of
> filesystem activity and use a 2:2 split all the time.  Appended patch is
> all that we need.

Your (tested) patch is not the same as what is being proposed here,
so the testing experience probably doesn't apply.

The 2:2 boundary is different here.
