Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUDDQjG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 12:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUDDQjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 12:39:06 -0400
Received: from host4.imagelinkusa.net ([66.246.17.209]:48100 "EHLO
	host4.imagelinkusa.net") by vger.kernel.org with ESMTP
	id S262462AbUDDQjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 12:39:04 -0400
Subject: [usbfs] 2.6.3+ devmode?
From: "Tony A. Lambley" <tal@vextech.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081096740.2235.6.camel@bony>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Apr 2004 12:39:00 -0400
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host4.imagelinkusa.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - vextech.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, is my brain going yolky? I have perm problems with a scanner after
each boot, and have to manually locate the scanner in /proc/bus/usb then
chmod it.

My fstab has:

none /proc/bus/usb usbfs defaults,devmode=0666 0 0

It happens with 2.6.3 through to .5. Am I doing something wrong or is
usbfs+devmode a bit under the weather?

Or maybe I shouldn't be using usbfs? Is it being depreciated?

