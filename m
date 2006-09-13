Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWIMMIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIMMIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 08:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWIMMIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 08:08:12 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23758 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750703AbWIMMIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 08:08:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Wed, 13 Sep 2006 14:07:41 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609081636310.7953-100000@iolanthe.rowland.org> <200609090057.49518.rjw@sisk.pl>
In-Reply-To: <200609090057.49518.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609131407.41936.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 9 September 2006 00:57, Rafael J. Wysocki wrote:
> On Friday, 8 September 2006 22:44, Alan Stern wrote:
> > On Fri, 8 Sep 2006, Andrew Morton wrote:
> > 
> > > Alan, is this likely to be due to your USB PM changes?
> > 
> > It's possible.  Most of those changes are innocuous.  They add routines
> > that don't get used until a later patch.  However one of them might be
> > responsible.
> 
> Well, after recompiling the kernel for several times (because of a different
> problem) I'm no longer able to reproduce the problem.

I have retested it on 2.6.18-rc6-mm1 and the problem sometimes happens.
It's not readily reproducible, as I said before, and it apparently doesn't
happen with gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch
reverted.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
