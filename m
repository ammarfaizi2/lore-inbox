Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269374AbUINNDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269374AbUINNDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUINNB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:01:28 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:336 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269375AbUINNAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:00:53 -0400
Message-ID: <4146EB80.9090801@yahoo.com.au>
Date: Tue, 14 Sep 2004 23:00:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move domain setup and add dual core support.
References: <m3vfeigs5b.fsf@averell.firstfloor.org>
In-Reply-To: <m3vfeigs5b.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Patch is for 2.6.9rc1-bk19. It's much smaller than it looks,
> most of it is just moving code from sched.c to sched-domains.h
> 

OK, I guess this should be alright... but it will clash badly
with the stuff in -mm, which really needs to get in.

And your patch will be much smaller because most of the moving
is done for you.
