Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUIOBTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUIOBTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266810AbUIOBTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:19:43 -0400
Received: from peabody.ximian.com ([130.57.169.10]:63419 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266805AbUIOBTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:19:33 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040915000753.GA24125@kroah.com>
References: <20040902083407.GC3191@kroah.com>
	 <1094142321.2284.12.camel@betsy.boston.ximian.com>
	 <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost>
	 <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org>
	 <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com>
Content-Type: text/plain
Date: Tue, 14 Sep 2004 21:19:27 -0400
Message-Id: <1095211167.20763.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 17:07 -0700, Greg KH wrote:

> I don't know, the firmware objects already use "add" for an event.  I
> didn't put a check in the kobject_uevent() calls to prevent the add and
> remove, but now it's a lot easier to do so if you think it's necessary.

I have no problem with this, either, so long as we are not too anal or
strict about adding new actions.

In other words, I like the safety and typo prevention that this gives
us, but want to keep things flexible and easy.

Best,

	Robert Love


