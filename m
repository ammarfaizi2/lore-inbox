Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273137AbRIYTiC>; Tue, 25 Sep 2001 15:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273135AbRIYThx>; Tue, 25 Sep 2001 15:37:53 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1284 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273127AbRIYThl>;
	Tue, 25 Sep 2001 15:37:41 -0400
Message-ID: <20010924210951.A165@bug.ucw.cz>
Date: Mon, 24 Sep 2001 21:09:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: GFP_FAIL?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I need to alloc as much memory as possible, *but not more*. I do not
want to OOM-kill anything. How do I do this? Tried GFP_KERNEL, will
oom-kill. GFP_USER will OOM-kill, too.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
