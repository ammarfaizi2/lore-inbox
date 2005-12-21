Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVLUVRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVLUVRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:17:34 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:30114 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751093AbVLUVRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:17:33 -0500
Subject: 2.6.15-rc5 and later: USB mouse IRQ post kills the computer post
	resume.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: vojtech@ucw.cz, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1135199640.9616.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 22 Dec 2005 07:14:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech.

I have a HT box with USB mouse support built as modules. Beginning with
2.6.15-rc5 (maybe slightly earlier) a suspend/resume cycle makes the USB
mouse get in an invalid state, such that I get a gazillion messages in
the logs saying "unexpected IRQ trap at vector 99", or in some
alternately a hard hang. No work around found yet. Are you the right man
to talk to, or is Greg? (Spose I should cc him, so I'll add that now). I
can use kdb if it's helpful. Would you like my kconfig?

I should probably mention that I've also gained problems with DRM (it's
Radeon based), but I don't think they're related. I'll email BenH on
that separately.

Regards,

Nigel

