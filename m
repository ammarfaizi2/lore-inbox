Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTIGVSx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTIGVSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:18:53 -0400
Received: from web14915.mail.yahoo.com ([216.136.225.228]:50335 "HELO
	web14915.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261542AbTIGVSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:18:52 -0400
Message-ID: <20030907211850.41983.qmail@web14915.mail.yahoo.com>
Date: Sun, 7 Sep 2003 14:18:50 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Mapping large framebuffers into kernel space
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kronos@kronoz.cjb.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something preventing kernel framebuffers from being mapped to the high
end of the 4GB kernel address space? Or do they have to be mapped below 1GB?
Framebuffer access isn't that performance sensitive, after all it is on the PCI bus.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
