Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTEBV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbTEBV7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:59:23 -0400
Received: from lug.gage.org ([205.179.65.215]:49933 "EHLO lug.gage.org")
	by vger.kernel.org with ESMTP id S263187AbTEBV7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:59:21 -0400
Date: Fri, 2 May 2003 15:11:16 -0700
From: jeff gerard <jeff-lk@gerard.st>
To: dok@convergence.de, jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] neofb: 1024x480 (picturebook) support
Message-ID: <20030502221116.GD29417@gage.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

here's a small patch for the neomagic framebuffer driver, to add support
for the 1024x480 LCD found on early models of sony vaio picturebooks.

this is similar to the libretto 800x480 hack already included in the
driver. below is for 2.5.66+, here's links to it, as well as a version for
2.4 which also backports the libretto support:

http://gerard.st/~jeff/neofb/neofb-picturebook-2.4.patch
http://gerard.st/~jeff/neofb/neofb-picturebook-2.5.patch

both patches create Documentation/fb/neofb.txt .

i calculated the numbers based on the X modeline. fbset says:

mode "1024x480-92"
    # D: 64.998 MHz, H: 48.362 kHz, V: 92.118 Hz
    geometry 1024 480 1024 2560 8
    timings 15385 168 8 32 11 144 2
    hsync high
    vsync high
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode


jeff

