Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTHQQrz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270416AbTHQQrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:47:55 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:49168 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270386AbTHQQrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:47:53 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Brandon Stewart <rbrandonstewart@yahoo.com>
Subject: Re: Hot swapping USB mouse in X window system
Date: Sun, 17 Aug 2003 20:48:15 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308172048.15232.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) If a mouse is not detected at the start of X windows, that mouse will 
> not be checked for during the operation of X windows.
> 2) If a mouse is detected at the start of X windows, then the device 
> corresponding to that mouse cannot be released until X windows is stopped

Use /dev/input/mice, it multiplexes all mice found and exists even if no 
device is currentrly available.

Under 2.6 I can "hot-plug" serial and PS2 mouse this way and use both at the 
same time.

-andrey
