Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWC3V2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWC3V2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWC3V2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:28:21 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:37022 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750969AbWC3V2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:28:17 -0500
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Handling devices that don't have a bus
Date: Thu, 30 Mar 2006 13:28:04 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301328.05431.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 12:45 pm, Alan Stern wrote:

> What's the right thing to do here?

I suppose one solution would be to use a class device, but that
gets into the utter pointlessness of having classes that may
never have more than a single member ... :)

