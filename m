Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTKPT0x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTKPT0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 14:26:53 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:27292 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261825AbTKPT0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 14:26:51 -0500
Date: Mon, 17 Nov 2003 06:26:44 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Terrible interactivity with 2.6.0-t9-mm3
Message-ID: <20031116192643.GB15439@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed major interactivity problems whilst ogging one of my
cds. X (which is running at a nice of 0) stuttered in its display
uptdates (eg: ogging on two seperate machines but displaying on one, 
the progress display of the much faster box would come in spurts until
I ^z the ogg on the box running X). Keyboard input also stutters
and the nfs connection (over which I was encoding from the X running
box) eventually gave up the ghost and I got lots of 'server not
responding, timed out' msgs.

Playing Heroes3 was also impossible until I ran it under nice -n 1.

Doh. :/ This is the first time this has been so bad that I've felt
it was worth writing about. :/

Systems:

X: P3-700 with 256MB RAM, half of it free running Debian sarge (libc
   2.3.2 and X 4.2.1.1) and 2.6.0-t9-mm3.
SSH: Athlon XP 2500+ with 512MB of RAM with all but 46MB free running
     the same version of Debian but with 2.6.0-t9-mm2.

-- 
  From the people who brought you burnt villages in Vietnam...

      http://news.independent.co.uk/world/middle_east/story.jsp?story=452375
