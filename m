Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWHYIqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHYIqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWHYIqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:46:34 -0400
Received: from smtp.agh.edu.pl ([149.156.96.16]:55936 "EHLO smtp.agh.edu.pl")
	by vger.kernel.org with ESMTP id S932249AbWHYIqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:46:33 -0400
Message-ID: <44EEB8EF.5050505@agh.edu.pl>
Date: Fri, 25 Aug 2006 10:46:39 +0200
From: Andrzej Szymanski <szymans@agh.edu.pl>
Organization: AGH University of Science and Technology, Dept. of Telecommunications
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
References: <44E0A69C.5030103@agh.edu.pl>	<ec19r7$uba$1@news.cistron.nl>	<17641.3304.948174.971955@cse.unsw.edu.au>	<44E9A9C0.6000405@agh.edu.pl>	<17642.46325.818963.951269@cse.unsw.edu.au> <17646.36219.417129.477853@cse.unsw.edu.au>
In-Reply-To: <17646.36219.417129.477853@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Tuesday August 22, neilb@suse.de wrote:
>> In my various experimenting the one thing that was effective in
>> improving the fairness was to make Linux impose write throttling more
>> often.
> 
> I might have found something else too....
> 
> Were you using ext3?
> 
> If you, can you try mounting with  data=writeback
> and see if that makes any difference to the fairness?
> 
> Thanks,
> NeilBrown

I've already tried data=writeback - almost no difference or it makes 
things even worse. I've briefly tested XFS filesystem, and I've seen the 
same behavior as in ext3 so it does not seem to be ext3 related.

Andrzej.
