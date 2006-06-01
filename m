Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWFATvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWFATvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWFATvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:51:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030247AbWFATvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:51:16 -0400
Date: Thu, 1 Jun 2006 12:53:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH] Allow TSO to be disabled for forcedeth driver
Message-Id: <20060601125359.10ca1f2b.akpm@osdl.org>
In-Reply-To: <447F3FB8.2010003@vmware.com>
References: <447F3FB8.2010003@vmware.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> wrote:
>
> TSO can cause performance problems in certain environments, and being 
> able to turn it on or off is helpful for debugging network issues.  Most 
> other network drivers that support TSO allow it to be toggled, so add 
> this feature to forcedeth.  Tested by Harald Dunkel, who reported that 
> this fixed his network performance issue with VMware.
> 

(This is regarding
http://www.vmware.com/community/thread.jspa?messageID=408893)


Why does TSO-with-forcedeth make vmware networking slow?

Is it specific to the forcedeth driver?
