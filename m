Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTKQDG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 22:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTKQDG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 22:06:59 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:17168 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S263269AbTKQDG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 22:06:58 -0500
Date: Sun, 16 Nov 2003 21:06:52 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: serio chaining in 2.6.x?
Message-ID: <20031117030652.GA4108@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a device (the device in question is the infamous cuecat) which
connects between the computer and a PS/2 device, and I'm trying to
figure out a good way to chain serio devices, such as:
	atkbd <-> cuecat <-> lowlevel driver

The serio driver, however, is very clearly not designed for such
chaining.  So, the question is:

What do you folks think the best method for chaining the
serio drivers is?

-- 
Zinx Verituse
