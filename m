Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUHZUek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUHZUek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269613AbUHZU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:29:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4840 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269586AbUHZUZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:25:49 -0400
Message-ID: <412E4740.3090807@pobox.com>
Date: Thu, 26 Aug 2004 16:25:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Zehetbauer <thomasz@hostmaster.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: netfilter IPv6 support
References: <1093546367.3497.23.camel@hostmaster.org>
In-Reply-To: <1093546367.3497.23.camel@hostmaster.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer wrote:
> Although linux was one of the first to support IPv6 it seems to me that
> netfilter support has almost stuck. There is still not even a REJECT
> target not to mention stateful filtering for IPv6.


google found for me an ip6_conntrack module, but...  some people make a 
credible argument that stateful filtering doesn't scale beyond small 
networks and small amounts of connections.  As Andi puts it, there is no 
infinite hash.

	Jeff


