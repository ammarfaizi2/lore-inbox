Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278967AbRJ2ETn>; Sun, 28 Oct 2001 23:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278979AbRJ2ETc>; Sun, 28 Oct 2001 23:19:32 -0500
Received: from codepoet.org ([166.70.14.212]:21838 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S278967AbRJ2ET0>;
	Sun, 28 Oct 2001 23:19:26 -0500
Date: Sun, 28 Oct 2001 21:20:06 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: r128 + agpgart + APM suspend = death
Message-ID: <20011028212006.A9278@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell Latitude C800 laptop.  It works just great and
I can use agpgart + r128 + XFree86 4.0.1 to get nice full 
screen 3D.  tuxracer looks nice.

But if I suspend my laptop when the agpgart module is loaded
is seems to suspend just fine, but will not resume....  Just
a black screen (of death).   If I ensure that the agpgart and
r128 modules are not loaded (by commenting out the 'Load "dri"'
line in /etc/X11/XF86Config-4, then killing X and unloading 
the modules) then I can suspend.

Anyone else seeing similar problems with APM + agpgart?
The problem has has been the same with all the 2.4.x kernels
I've tried it on, though I am running 2.4.12-ac6 at the moment.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
