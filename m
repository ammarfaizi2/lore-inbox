Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVBINvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVBINvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 08:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVBINvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 08:51:37 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:45748 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261821AbVBINvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 08:51:32 -0500
Date: Wed, 9 Feb 2005 14:51:31 +0100
To: linux-kernel@vger.kernel.org
Subject: intelligent pre-configuration
Message-ID: <20050209135129.GM31026@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Thu Feb 10 14:04:00 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maybe it's nice to have a pre-kernel-configuration-auto-configurator script
in the kernel.
Like, something that detects (by parsing lspci/lsusb/lssbus's output or so)
what hardware is on-board and then creates an initial .config for your
kernel. That way the chance that you accidently forgot to include that
important ACPI-module (for your laptop) which prevents your processor from
burning gets smaller.


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
