Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWINPYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWINPYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWINPYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:24:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:32984 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750768AbWINPYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:24:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Thu, 14 Sep 2006 17:23:49 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>
References: <fa.IgLMAmyDbz1yS9bpHhwK3NW+uks@ifi.uio.no> <fa.L0QDp0UiCRLE2HbZGTyQ/fbNwDU@ifi.uio.no> <45096716.6050507@shaw.ca>
In-Reply-To: <45096716.6050507@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141723.49915.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 16:28, Robert Hancock wrote:
> Rafael J. Wysocki wrote:
> > BTW, all of the systems on which the problem shows up seem to be 64-bit.
> > 
> > If you can't reproduce it on a 32-bit system, some type casting may be wrong
> > somewhere.
> > 
> > Greetings,
> > Rafael
> 
> I'm getting this problem on a 32-bit system (see my report in reply to 
> Andrew's 2.6.18-rc6-mm2 announcement). The EHCI driver won't suspend on 
> the second attempt after bootup.

Ah, so I was wrong.

I've seen your report, but I thought it was a 64-bit system for some reason.
Sorry for the confusion.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
