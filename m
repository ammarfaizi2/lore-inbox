Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUKKV6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUKKV6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUKKV5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:57:15 -0500
Received: from mail.charite.de ([160.45.207.131]:19670 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262376AbUKKVzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:55:31 -0500
Date: Thu, 11 Nov 2004 22:55:30 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: FB: vesafb garbled after using X11 with nv driver
Message-ID: <20041111215530.GB24338@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the nv driver in XFree and the vesafb for the framebuffer console.
vesafb works fine, I get the bootlogo and all during boot. 

Once X11 starts up and I want to switch back to the framebuffer
console using CTRL-ALT-F1, the framebuffer is garbled. The screen is
flickering, as if the vertical synchronisation is lost. Colors seem to
be OK, I get grey garbage on black background.

Switching back to X11 using ALT-F7 works OK, the X11 screen looks fine.

I made two screenshots to illuminate what I'm seeing:
http://www.stahl.bau.tu-bs.de/~hildeb/bugreport/dsc02089.jpg
http://www.stahl.bau.tu-bs.de/~hildeb/bugreport/dsc02090.jpg
(watch out, high resolution)

It's not entirely clear if it's an issue of the nv driver or the vesafb
in the kernel.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
