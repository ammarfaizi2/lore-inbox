Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDHUrb (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTDHUrb (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:47:31 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:3070 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261710AbTDHUr0 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 16:47:26 -0400
Date: Tue, 8 Apr 2003 22:56:23 +0200
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030408205623.GA5253@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and the deprecation of "cardmgr" and "cardctl"

Dear kernel developers and testers,

Updated and re-diffed revisions of my pcmcia-related patches are 
available at http://www.brodo.de/pcmcia/

These patches update the PCMCIA subsystem (16-bit) to use the driver
model matching and hotplug utilities. The "cardmgr" will not be 
needed any longer - in fact, it won't even work any longer.

They are based on kernel 2.5.67

Many thanks to David Hinds for the great PCMCIA package to build this
work onto, to David Woodhouse for parts of the code and many ideas,
to Russell King, Greg Kroah-Hartman for their insight, and to Patrick
Mochel for the great linux driver model which made implementing this
so much easier.

A descritption of each patch, and more information can be found at the said
website, http://www.brodo.de/pcmcia/index.html

	Dominik
