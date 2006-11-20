Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966833AbWKTWEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966833AbWKTWEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbWKTWEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:04:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:7339 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966833AbWKTWEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:04:11 -0500
Message-ID: <45622654.7030400@garzik.org>
Date: Mon, 20 Nov 2006 17:04:04 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Arnd Bergmann <arnd@arndb.de>, Chris Snook <csnook@redhat.com>,
       Jay Cliburn <jacliburn@bellsouth.net>, romieu@fr.zoreil.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
References: <20061119203050.GD29736@osprey.hogchain.net>	<200611200057.45274.arnd@arndb.de>	<45614769.4020005@redhat.com>	<200611201322.00495.arnd@arndb.de>	<20061120100202.6a79e382@freekitty>	<4562036E.3020409@garzik.org>	<20061120121524.68cf39d8@freekitty>	<45621FEB.204@garzik.org> <20061120135959.66debead@freekitty>
In-Reply-To: <20061120135959.66debead@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> What I would like is for the mii core to maintain the bits (like advertising)
> in the mii structure and if not running, it should just change the offline
> copy, then when link is brought up use the changes that were requested while
> link was down. Understand?
> 
> That's why in the skge/sky2, I keep state bits and don't apply them until
> link is started. If mii (and phylib) did this, I could use them; but as it
> is they require PHY to be powered all the time.


You have the power to change it :)  But need to review the other drivers 
to assess the impact of the change, of course.

	Jeff


