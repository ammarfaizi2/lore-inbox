Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWFSSWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWFSSWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWFSSWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:22:04 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:56008 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S964808AbWFSSWC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:22:02 -0400
Message-ID: <4496EB2E.2000106@nortel.com>
Date: Mon, 19 Jun 2006 12:21:34 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org, mingo@elte.hu,
       pwil3058@bigpond.net.au, sekharan@us.ibm.com, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <4494EE86.7090209@yahoo.com.au>  <20060617234259.dc34a20c.akpm@osdl.org> <1150616176.7985.50.camel@Homer.TheSimpsons.net>
In-Reply-To: <1150616176.7985.50.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 18:21:39.0170 (UTC) FILETIME=[34E5EC20:01C693CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

> Scheduling contexts do sound useful.  They're easily defeated though, as
> evolution mail demonstrates to me every time it's GUI hangs and I see
> that a nice 19 find is running, eating very little CPU, but effectively
> DoSing evolution nonetheless (journal).  I wonder how often people who
> tried to distribute CPU would likewise be stymied by other resources.

We do a lot with diskless blades.  Basically cpu(s), memory, and network 
ports.

For this case, cpu, memory, and network controllers are sufficient. 
Even just cpu gets you a long way, since mostly we're not IO-intensive 
and we generally have a pretty good idea of memory consumption.

Chris
