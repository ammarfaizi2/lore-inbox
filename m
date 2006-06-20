Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWFTUye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWFTUye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWFTUyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:54:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19425 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751037AbWFTUyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:54:33 -0400
Message-ID: <44986083.9050503@garzik.org>
Date: Tue, 20 Jun 2006 16:54:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Andi Kleen <ak@suse.de>, Dave Olson <olson@unixfolk.com>,
       discuss@x86-64.org, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>	<fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no>	<Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>	<200606200925.30926.ak@suse.de>	<20060620200352.GJ1414@greglaptop.internal.keyresearch.com> <adaejxjo9ua.fsf@cisco.com>
In-Reply-To: <adaejxjo9ua.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> However, the other issue is that CONFIG_PCI_MSI forces some other
> changes to x86 interrupt handling, even if no devices will ever use
> MSI.  And the changes are such that some systems can't even boot with
> CONFIG_PCI_MSI enabled.  This is the more severe problem, which needs
> to be handled if you want distros to turn on MSI.

Agreed.  We definitely want CONFIG_PCI_MSI-enabled kernels to work in 
all situations.

	Jeff


