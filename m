Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbUCYUg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUCYUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:36:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263610AbUCYUg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:36:56 -0500
Message-ID: <406342DA.30901@pobox.com>
Date: Thu, 25 Mar 2004 15:36:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Sridhar Samudrala <sri@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain> <20040325123206.00b2dd1a.davem@redhat.com>
In-Reply-To: <20040325123206.00b2dd1a.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Thu, 25 Mar 2004 12:17:41 -0800 (PST)
> Sridhar Samudrala <sri@us.ibm.com> wrote:
> 
> 
>>The following patch to 2.6.5-rc2 consolidates 6 different implementations
>>of msecs to jiffies and 3 different implementation of jiffies to msecs.
>>All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
>>that are added to include/linux/time.h
> 
> 
> This looks fine to me.
> 
> Jeff, I'll merge this upstream.


Nod, looks good here too.

	Jeff



