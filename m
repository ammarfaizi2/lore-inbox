Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTHZRZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbTHZRZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:25:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42974 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261711AbTHZRZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:25:54 -0400
Message-ID: <3F4B9814.2090202@pobox.com>
Date: Tue, 26 Aug 2003 13:25:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Francois Romieu <romieu@fr.zoreil.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bk patches] net driver updates
References: <20030817183137.GA18521@gtf.org> <20030823154231.A11381@electric-eye.fr.zoreil.com> <20030826171754.GD16831@matchmail.com>
In-Reply-To: <20030826171754.GD16831@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Sat, Aug 23, 2003 at 03:42:31PM +0200, Francois Romieu wrote:
> 
>>Jeff Garzik <jgarzik@pobox.com> :
>>[net-drivers-2.6 update]
>>
>>> drivers/net/sis190.c              | 2094 +++++++++++++++++++++++++++++---------
>>
>>
>>synchronize_irq() requires an argument when built with CONFIG_SMP.
> 
> 
> Shouldn't it also require it for the UP case?  Or is this one of those
> subtle things that tells you it's not working on SMP?


the latter :)

	Jeff



