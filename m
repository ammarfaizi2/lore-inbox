Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWINRYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWINRYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWINRYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:24:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:7182 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750801AbWINRYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:24:10 -0400
Date: Thu, 14 Sep 2006 13:24:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609141913.19492.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609141323110.5715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:

> Okay, this is not reproducible, so I gather it was due to my other problem
> with the USB resume (sigh).
> 
> Anyway, the second suspend/resume worked just fine, so the patch apparently
> helps.

Doing the simpler tests, with only one USB host driver at a time, is still 
the best way to go.  Once they both work with USB_SUSPEND turned off, 
we'll try them with USB_SUSPEND turned on.

Alan Stern

