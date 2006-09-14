Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWINLUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWINLUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWINLUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:20:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:20182 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751141AbWINLUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:20:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Date: Thu, 14 Sep 2006 13:19:53 +0200
User-Agent: KMail/1.9.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609131558.03391.rjw@sisk.pl> <Pine.LNX.4.44L0.0609131441080.6684-100000@iolanthe.rowland.org> <20060913153158.612ef473.zaitcev@redhat.com>
In-Reply-To: <20060913153158.612ef473.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141319.53942.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 00:31, Pete Zaitcev wrote:
> On Wed, 13 Sep 2006 14:44:48 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > This problem has already been identified by Pete Zaitcev in this thread:
> > 
> > 	http://marc.theaimsgroup.com/?t=115769512800001&r=1&w=2
> > 
> > Perhaps Pete has an updated patch to fix the problem.  If not, I could 
> > write one.
> 
> No, not yet. I am working on getting David's approach with irq = -1
> tested at Stratus. Since it was the only reproducer known to me, I wanted
> to test. Now that Rafael has a fault case, I'll expedite.

In fact I can reproduce it on two different boxes now.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
