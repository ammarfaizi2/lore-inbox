Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTKTFYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTKTFYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:24:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44462 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261368AbTKTFYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:24:16 -0500
Message-ID: <3FBC4FE0.2020705@pobox.com>
Date: Thu, 20 Nov 2003 00:23:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: netdev@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 2.6.x experimental net driver updates
References: <3FBBA954.6000601@pobox.com> <20031120025423.GB24159@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031120025423.GB24159@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Nov 19, 2003 at 12:33:08PM -0500, Jeff Garzik wrote:
> 
>>Ok, Al Viro's net driver refcounting work is pretty much complete, and 
> 
> 
> The hell it is.  We are through with legacy probes, we are through with
> init_etherdev(), we are practically through with static struct net_device.

hehe :)  I don't mean to suggest that all is clean and pure :)


> However, we still have weird allocators (I've got almost all of them
> done by now, will submit in the next batch) and we still have struct
> net_device embedded as a field of other structures in several drivers.

Some of that will be interesting.  ns83820 for example embedded 
net_device on purpose...  Ben seemed to think at the time it gave him 
some speed, a few less pointer derefs and such.

	Jeff



