Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVCJFt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVCJFt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVCJFq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:46:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4261 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261710AbVCJFpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:45:22 -0500
Message-ID: <422FDEE3.5090306@pobox.com>
Date: Thu, 10 Mar 2005 00:45:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata-2.6] AHCI: fix fatal error int handling
References: <20050309205714.DBED014FA3@lns1032.lss.emc.com>
In-Reply-To: <20050309205714.DBED014FA3@lns1032.lss.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> I noticed that the AHCI CI (cmd issue) reg wasn't getting cleared
> after error ints resulting in no further commands being successfully
> issued to the port.  This patch fixes.  All that's really needed is
> the 1's complement but I also removed the disabling/enabling of the
> FIS_RX b/c this isn't spec'd as necessary when handling error ints.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

Thanks, applied.


