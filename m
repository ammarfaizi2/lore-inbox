Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbTLHEwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTLHEwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:52:08 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:58240 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265334AbTLHEwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:52:06 -0500
Subject: usbfs mount options doesn't work in 2.6, works fine with 2.4
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1070859138.1882.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 05:52:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noted that whatever mount options I use on usbfs, they are
ignored. Works just fine on 2.4. Is this something other people are
experiencing as well, or is this some kind of configuration problem? I'm
having this line in fstab:

usbfs   /proc/bus/usb   usbfs   defaults,devmode=0666   0       0

which does what I want with 2.4, but not 2.6..

Best regards,
Stian

