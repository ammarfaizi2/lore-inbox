Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVLHUiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVLHUiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLHUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:38:20 -0500
Received: from mail.dvmed.net ([216.237.124.58]:683 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932361AbVLHUiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:38:19 -0500
Message-ID: <439899B6.2000302@pobox.com>
Date: Thu, 08 Dec 2005 15:38:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Backlund <tmb@mandriva.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
References: <20051204011953.GA16381@havoc.gtf.org> <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com> <43987A28.8070509@mandriva.org>
In-Reply-To: <43987A28.8070509@mandriva.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Thomas Backlund wrote: > Richard Bollinger wrote: >>>
	ata1: BUG: SG size underflow >>> ata1: status=0x50 { DriveReady
	SeekComplete } > > > and onde by one the raid devices got deactivated
	until the full freeze... [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Backlund wrote:
> Richard Bollinger wrote:
>>> ata1: BUG: SG size underflow
>>> ata1: status=0x50 { DriveReady SeekComplete }
> 
> 
> and onde by one the raid devices got deactivated until the full freeze...


I think I know what's going on with the 'SG size underflow' thingy, give 
me a few days to come up with a fix.

	Jeff


