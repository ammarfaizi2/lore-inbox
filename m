Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266151AbUFYBRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266151AbUFYBRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 21:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUFYBRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 21:17:50 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:56229 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266151AbUFYBRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 21:17:49 -0400
Message-ID: <40DB7D25.1090207@yahoo.com.au>
Date: Fri, 25 Jun 2004 11:17:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com, tiwai@suse.de,
       ak@suse.de, ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
References: <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624151130.4a444973.akpm@osdl.org> <20040624230919.GB30687@dualathlon.random>
In-Reply-To: <20040624230919.GB30687@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> Your code must be inferior since it doesn't even allow to tune each zone
> differently (you seems not to have a lower_zone_reserve_ratio[idx]). Not sure
> why you dont' simply forward port the code from 2.4 instead of reinventing it.
> 

It can easily be modified if required though. Is there a need to be
tuning these different things? This is probably where we should hold
back on the complexity until it is shown to improve something.
