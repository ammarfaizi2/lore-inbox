Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUEFNKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUEFNKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEFNKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:10:50 -0400
Received: from ns.schottelius.org ([213.146.113.242]:25494 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S262109AbUEFNKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:10:48 -0400
Date: Thu, 6 May 2004 15:10:55 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: USB OHCI selected, EHCI should be used
Message-ID: <20040506131055.GF1279@schottelius.org>
References: <20040506122112.GE1279@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506122112.GE1279@schottelius.org>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.3
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When I have loaded only ehci, my usb 2.0 devices are attached
as usb 2.0.
If I have loaded ohci and ehci, my usb 2.0 devices are handled by
ohci. 

My question: Why? Shouldn't ohci be the fallback and ehci default?

I have the following usb controllers:

0000:00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 50)
0000:00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 50)
0000:00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
0000:00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)

One is handled by uhci (for the internal wlan card), 
two are handled by ohci (for external 1.1 devices) and
one is handled by ehci (should be for external 2.0 devices).

Any hint appreciated!

Nico

please cc me..
