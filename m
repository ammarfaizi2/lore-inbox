Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVDLW0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVDLW0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVDLWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:22:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:31468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262155AbVDLWVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:21:42 -0400
Date: Tue, 12 Apr 2005 15:21:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Amelia Nilsson <dhakela@linuxchick.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugreport
Message-ID: <20050412222131.GV28536@shell0.pdx.osdl.net>
References: <20050412201152.6b11ec9a.dhakela@linuxchick.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412201152.6b11ec9a.dhakela@linuxchick.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Amelia Nilsson (dhakela@linuxchick.se) wrote:
> I've found a bug in 2.6.11.6. I have a Toshiba laptop and when i did
> run 2.6.11.6 my touchpad flipped out, it clicked everywhere when it
> wasn't supposed to click. I couldn't even move my mouse without it was
> clicking all over. It works fine i 2.6.10 though. Is there any changes
> made that can affect this? (I haven't tried 2.6.11.7 yet...)

2.6.11.7 has no significant changes that should effect your touchpad.
We'll need much more information to make any headway here (see
REPORTING-BUGS).  I've got a Toshiba laptop, and have no issues with the
touchpad.  I assume this is an issue in just in X.  Do you see any obvious
difference in the Xorg.0.log when starting X on the two different kernels?
Any interesting dmesg output on the failing kernel?  Does booting with
psmouse.proto=exps help (assuming you have CONFIG_MOUSE_PS2=y)?

thanks,
-chris
