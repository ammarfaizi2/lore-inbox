Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUBBMou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUBBMou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:44:50 -0500
Received: from bacchus.cwi.nl ([192.16.191.9]:55782 "EHLO bacchus.cwi.nl")
	by vger.kernel.org with ESMTP id S265477AbUBBMot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:44:49 -0500
Date: Mon, 2 Feb 2004 13:44:40 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200402021244.i12Cien08901.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, vojtech@suse.cz
Subject: Re: 2.6 input drivers FAQ
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> all reasonable kernels support the ioctls

Just checked. KDKBDREP support was added in 2.4.9. Still a bit recent.

> when you're in X, and root, the ioctls will fail but /dev/port will still work

Yes, I think I'll check that stdin is a console, and otherwise do the /dev/port
stuff only when a --portio option was given. I try to avoid testing kernel
version values.

> EVIOCSKEYCODE

Will look at that.

Andries
