Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVBGWi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVBGWi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVBGWiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:38:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3808 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261288AbVBGWih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:38:37 -0500
Date: Mon, 7 Feb 2005 23:38:33 +0100
From: Martin Mares <mj@ucw.cz>
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Dynids - passing driver data
Message-ID: <20050207223833.GA2651@atrey.karlin.mff.cuni.cz>
References: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com> <20050207221820.GA27543@kroah.com> <4207ECDB.7060506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207ECDB.7060506@us.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >Which is a good thing, right?  "driver_data" is usually a pointer to
> >somewhere.  Having userspace specify it would not be a good thing.
> 
> That depends on the driver usage, and the patch allows it to be 
> configurable and defaults to not being used.

Maybe we could just define the operation as cloning of an entry
for another device ID, including its driver_data.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Only dead fish swim with the stream.
