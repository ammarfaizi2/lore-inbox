Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVBSQbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVBSQbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 11:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVBSQbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 11:31:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18825 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261707AbVBSQbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 11:31:14 -0500
Message-ID: <421769BD.4060606@pobox.com>
Date: Sat, 19 Feb 2005 11:30:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: ncunningham@cyclades.com, kwijibo@zianet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Should kirqd work on HT?
References: <88056F38E9E48644A0F562A38C64FB60040DBACB@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60040DBACB@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
> You are right. Kernel balancer doesn't move around the irqs, unless it
> has too many interrupts. The logic is moving around interrupts all the
> time will not be good on caches. So, there is a threshold above which
> the balancer start moving things around.
> 
> You should see them moving around if you do 'ping -f' or a big 'dd' from
> the disk.

If kirqd is moving NIC interrupts, it's broken.

(and another reason why irqbalanced is preferable)

	Jeff



