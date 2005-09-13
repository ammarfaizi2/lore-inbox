Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVIMOP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVIMOP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVIMOP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:15:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63269
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964790AbVIMOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:15:58 -0400
Date: Tue, 13 Sep 2005 16:16:18 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: linux-kernel@vger.kernel.org, klive@cpushare.com,
       Ian Wienand <ianw@gelato.unsw.edu.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git tag in localversion
Message-ID: <20050913141618.GX13439@opteron.random>
References: <20050912210836.GL13439@opteron.random> <d120d5000509121431765f52c8@mail.gmail.com> <20050912222137.GP13439@opteron.random> <20050913083120.GG5276@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913083120.GG5276@mythryan2.michonline.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:31:27AM -0400, Ryan Anderson wrote:
> My suggestion would be to classify these wherever they would fall if the
> -gXXXXXXXX wasn't present, as they fall into the same category.

I was considering doing this last night.

OTOH if I do that, I should merge the -git(\d+) in the same category
too.

> They won't get as much testing, but if you see 5 or 10 of these in the
> same category and -rc range, that's a good indication that a few people
> are testing those kernels.

Right now I simply moved them from unknown to the mainline branch, but I
still leave them separated like the -git(\d+) tags.

I probably should change that and merge after removing hte -g and -git
tags (of course without discarding the tag but showing it after clicking
on the kernel release).

Thanks.
