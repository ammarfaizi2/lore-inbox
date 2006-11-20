Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966881AbWKTXSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966881AbWKTXSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966877AbWKTXSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:18:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:16018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966521AbWKTXSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:18:36 -0500
Date: Mon, 20 Nov 2006 15:17:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Snook <csnook@redhat.com>,
       Jay Cliburn <jacliburn@bellsouth.net>, romieu@fr.zoreil.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
Message-ID: <20061120151702.054bc541@dxpl.pdx.osdl.net>
In-Reply-To: <45622654.7030400@garzik.org>
References: <20061119203050.GD29736@osprey.hogchain.net>
	<200611200057.45274.arnd@arndb.de>
	<45614769.4020005@redhat.com>
	<200611201322.00495.arnd@arndb.de>
	<20061120100202.6a79e382@freekitty>
	<4562036E.3020409@garzik.org>
	<20061120121524.68cf39d8@freekitty>
	<45621FEB.204@garzik.org>
	<20061120135959.66debead@freekitty>
	<45622654.7030400@garzik.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 17:04:04 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Stephen Hemminger wrote:
> > What I would like is for the mii core to maintain the bits (like advertising)
> > in the mii structure and if not running, it should just change the offline
> > copy, then when link is brought up use the changes that were requested while
> > link was down. Understand?
> > 
> > That's why in the skge/sky2, I keep state bits and don't apply them until
> > link is started. If mii (and phylib) did this, I could use them; but as it
> > is they require PHY to be powered all the time.
> 
> 
> You have the power to change it :)  But need to review the other drivers 
> to assess the impact of the change, of course.

planned to, in due course.
