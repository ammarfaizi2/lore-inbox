Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTELUlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTELUlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:41:00 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:22242 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S262671AbTELUk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:40:58 -0400
Subject: USB mouse freezes under X, 2.5.69-mm3
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Organization: 
Message-Id: <1052772819.4835.6.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 May 2003 13:53:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I occasionally see my USB mouse freeze up under X11 on a Red Hat 9
system running 2.5.69-mm3.  It completely stops responding to events
until I either switch virtual terminals or restart X, then magically
comes back to life.

There are no entries in /var/log/messages to indicate what might be
going on, so I'm quite mystified.

This is on a system with USB compiled in modular form, though I notice
that, weirdly enough, the refcounts on everything USB-related except
usbcore are zero (i.e. hid, uhci_hcd, ehci_hcd), even though I'm using
the USB mouse right now.

	<b

