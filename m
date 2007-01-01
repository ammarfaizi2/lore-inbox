Return-Path: <linux-kernel-owner+w=401wt.eu-S1751665AbXAAVwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbXAAVwE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbXAAVwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:52:04 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:60985 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbXAAVwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:52:03 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Andrew Barr <andrew.james.barr@gmail.com>
Subject: Re: Cut power to a USB port?
Date: Mon, 1 Jan 2007 22:52:02 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <1167684985.28023.4.camel@localhost>
In-Reply-To: <1167684985.28023.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701012252.02647.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. Januar 2007 21:56 schrieb Andrew Barr:
> I have a simple question perhaps someone can help me with here...
> 
> I have one of those simple LED keyboard lamps that get their power from
> the USB port. Is there some way in Linux, using files under /sys I would
> imagine, to cut power to the USB port into which this lamp is plugged? I

You could use usbfs to send commands to the hub.

> know I would have to manually figure out what port it's plugged into, as
> it is not a "real" USB device...e.g. it just draws power. I would like
> to be able to programmatically switch the lamp on and off.

The ability to cut each port's power individually is optional. Your
hardware may well be incapable of what you want.

	Regards
		Oliver

