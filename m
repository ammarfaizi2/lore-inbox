Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUGONMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUGONMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUGONMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:12:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35719 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266194AbUGONLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:11:52 -0400
Message-ID: <40F68287.1010309@pobox.com>
Date: Thu, 15 Jul 2004 09:11:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Woods <dwoods@fastclick.com>
CC: linux-kernel@vger.kernel.org,
       Stephanie Marasciullo <smarasciullo@fastclick.com>
Subject: Re: Problems with DMA on IDE/ServerWorks/Seagate.
References: <7632915A8F000C4FAEFCF272A880344105095A@Ehost067.exch005intermedia.net>
In-Reply-To: <7632915A8F000C4FAEFCF272A880344105095A@Ehost067.exch005intermedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Woods wrote:
> Please CC me on all replies, as I am not subscribed to the list.
> 
> We have diagnosed a problem (file corruption) using Ultra DMA & IDE with
> 
> ServerWorks OSB4 Chipset and Seagate drives under heavy disk I/O.


Known -- do NOT use Ultra DMA.

MWDMA should work.

	Jeff


