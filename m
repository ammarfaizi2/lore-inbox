Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUDZTvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUDZTvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbUDZTvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:51:06 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:35077 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S263415AbUDZTuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:50:54 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
	<408D65A7.7060207@nortelnetworks.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gisfm34kq.fsf@patl=users.sf.net>
Date: 26 Apr 2004 15:50:52 -0400
In-Reply-To: <408D65A7.7060207@nortelnetworks.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> Patrick J. LoPresti wrote:
> 
> > For example, I invoke "modprobe hid" to make my USB keyboard work.
> > This loads the module and exits immediately, causing my script to
> > proceed, before the USB keyboard is probed and ready.
> > I want to wait until the driver is finished initializing (i.e., a USB
> > keyboard is either found or not found) before my script continues.
> > How can I do that?
> 
> How about scanning the usb device tree to see if the keyboard is
> present and properly detected?

You mean under sysfs or usbfs?  Or both?

I see how I can scan for a USB keyboard after loading the USB host
controller module.  I think.  But what do I look for, exactly, to tell
when hid.o has hooked itself up to the keyboard?

 - Pat
