Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJLPZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJLPZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUJLPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:25:48 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:41179 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265697AbUJLPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:25:12 -0400
Message-ID: <416BF72F.2080804@nortelnetworks.com>
Date: Tue, 12 Oct 2004 09:24:31 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com> <20041012052210.GW9106@holomorphy.com>
In-Reply-To: <20041012052210.GW9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Oct 11, 2004 at 11:03:16PM -0600, Chris Friesen wrote:
> 
>>I must be able to run an app that uses over 90% of system memory, and calls 
>>fork().  I was under the impression this made strict accounting unfeasable?
> 
> 
> Not so. Just add enough swapspace to act as the backing store for the
> aggregate anonymous virtualspace.

In my first message I mentioned that I had no swap.  It's embedded, so I do not 
have the ability to add swap.

Chris
