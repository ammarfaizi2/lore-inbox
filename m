Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTI3WFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTI3WFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:05:46 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:42213 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261749AbTI3WFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:05:38 -0400
To: Henrik Christian Grove <grove@sslug.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Radeon framebuffer problems i 2.6.0-test6
References: <7gisna11e1.fsf@serena.fsr.ku.dk>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Oct 2003 00:05:34 +0200
In-Reply-To: <7gisna11e1.fsf@serena.fsr.ku.dk>
Message-ID: <m2ad8mgcep.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Christian Grove <grove@sslug.dk> writes:

> I have an Asus L3800C laptop with a Radeon Mobility 7500 graphics
> chip. 
> 
> I have made three slightly different 2.6.0-test6 kernels, called
> test6-1, test6-2 and test6-3. The only differences are what framebuffer
> drivers are included. Test6-1 includes both the vga16 driver and the
> radeon driver, test6-2 only includes the radeon driver, and test6-3 only
> includes the vga16 driver.
> 
> With test6-2 I get a framebuffer that looks like it has a sync
> problem. Horizontal lines are horizontal, but vertical lines are
> displayed as individual dots, for each horizontal line of pixels 8
> pixels further right.

See http://www.ussg.iu.edu/hypermail/linux/kernel/0308.3/0637.html
That patch fixed the same problem for me.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
