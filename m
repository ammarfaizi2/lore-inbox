Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTGOGX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTGOGX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:23:28 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:31616 "EHLO
	darkwood.somewhere") by vger.kernel.org with ESMTP id S263743AbTGOGWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:22:45 -0400
Date: Tue, 15 Jul 2003 08:00:51 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@angry-pixels.com>
To: linux-kernel@vger.kernel.org
Subject: radeonfb and 32bit depth
Message-ID: <20030715060051.GA5738@darkwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing radeonfb in 2.4.22-pre6, my card is Sapphire 9100.

Everything works great in 8bit depth.

But when I use for example following mode:

mode "640x480-100@32"
	geometry 640 480 640 480 32
        timings 22272 48 32 17 22 128 12
endmode

cursor changes to black.

-- 
Free Software - find interesting programs and change them
NetHack - meet interesting creatures, kill them and eat their bodies
Usenet - meet interesting people from all over the world and flame them
Decopter - unrealistic helicopter simulator, get it from http://decopter.sf.net
