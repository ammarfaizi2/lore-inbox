Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264971AbUFGST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUFGST6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUFGST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:19:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38545 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264971AbUFGSTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:19:55 -0400
Message-ID: <40C4B1BD.1020503@pobox.com>
Date: Mon, 07 Jun 2004 14:19:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: ethtool power manglement hooks
References: <20040607155018.GA5810@devserv.devel.redhat.com>
In-Reply-To: <20040607155018.GA5810@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Several ethernet drivers have been broken by the ethtool support because
> the ioctl code used to power the interface up and down as needed. Rather
> than add this to each driver call Jeff Garzik suggested we add hooks
> for before/after ethtool processing.
> 
> This patch implements them which makes fixing the PM stuff easier,
> as the epic100 patch to follow will show. It also cleans up the 
> via-velocity driver pm/ethtool logic a great deal. As per Jeff's
> request the before handler is allowed to fail the operation.

Thanks A.

BTW, if you have a free moment, I don't think all your comments from 
your months-ago review of net/core/ethtool.c were addressed.  A 
re-review would be appreciated.  In the meantime, I'm hunting around for 
your original review.

	Jeff



