Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbUBYAxq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbUBYAxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:53:46 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:14540 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262343AbUBYAxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:53:45 -0500
Date: Wed, 25 Feb 2004 00:52:41 +0000
From: Dave Jones <davej@redhat.com>
To: greg@kroah.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: usb-uhci rmmod fun
Message-ID: <20040225005241.GB11203@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, greg@kroah.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
 wtf is going on here ?

(00:52:08:root@mindphaser:davej)# lsmod | grep floppy
(00:52:39:root@mindphaser:davej)# modprobe usb-uhci
(00:52:48:root@mindphaser:davej)# lsmod | grep floppy
(00:53:02:root@mindphaser:davej)# rmmod uhci_hcd
(00:53:11:root@mindphaser:davej)# lsmod | grep floppy
floppy                 58260  0
(00:53:13:root@mindphaser:davej)#

Unloading the usb controller loads the floppy controller!?

		Dave

