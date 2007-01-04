Return-Path: <linux-kernel-owner+w=401wt.eu-S965128AbXADW0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXADW0r (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbXADW0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:26:47 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33683 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965120AbXADW0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:26:46 -0500
Message-ID: <459D7F23.7010807@garzik.org>
Date: Thu, 04 Jan 2007 17:26:43 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [RFC,PATCHSET] Managed device resources
References: <1167146313307-git-send-email-htejun@gmail.com> <20070104221916.GI28445@suse.de>
In-Reply-To: <20070104221916.GI28445@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Hm, but I guess without the follow-up patches for libata, it will not
> really get tested much.  Jeff, if I accept this, what's your feelings of
> letting libata be the "test bed" for it?


It would be easiest for me to merge this through my 
libata-dev.git#upstream tree.  That will auto-propagate it to -mm, and 
ensure that both base and libata bits are sent in one batch.

Just shout if you see NAK-able bits...

Work for you?

	Jeff


