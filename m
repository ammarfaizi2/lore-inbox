Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUDFLNq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDFLMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:12:33 -0400
Received: from postit.mail.adnap.net.au ([203.6.132.68]:40203 "EHLO
	postit.mail.adnap.net.au") by vger.kernel.org with ESMTP
	id S263764AbUDFLIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:08:02 -0400
Date: Tue, 6 Apr 2004 20:47:28 +0930
From: David Lloyd <lloy0076@adam.com.au>
To: linux-kernel@vger.kernel.org
Subject: Text Console Mode && Sync on Green 60 Hz Monitors with 2.6.4
Message-Id: <20040406204728.1f028e85.lloy0076@adam.com.au>
Organization: David Lloyd
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi There,

I have a special card that is able to run my ancient Sync on Green, 60
Hz (vertical) monitor. It's a 21", genuine trinitron tube monitor with
excellent colour definition and I like it - it's my precioussss and
we're not going to stop using it.

Now, this monitor and my video card display the following
characteristics:

 * if it runs in graphical mode the scan modelines MUST be 60 Hz
   (vertical) _and_ it must be within about 1% of 60Hz

 ModeLine "Left 1280x1024"   108.00 1280 1284 1452 1680 1024 1030 1033
 1066 -hsync -vsync

 - if the values change or go "wrong" the video card and adapter get
   totally confused and essentially I lose sync and can't get it back
   again

 * if it runs in text mode it runs fine

It does NOT run in Framebuffer mode nicely.

Now, I've downloaded:

  2.6.4 (from the Debian source tree)
  
  and

  2.6.4 (from a kernel.org mirror)

  ...now I've turned off framebuffer support but 2.6.4 sends my
  monitor/card combo into no-sync. I've set the "video=vga16:off" in
  lilo.

Funnily enough, I've basically imported the settings from my older
2.6.0-test9 [a Debian version] which DOES work and it still upsets my
monitor. It works under 2.4.18-bf2.4.

I am wondering what might have changed if anything...

DSL

--
Open Source Business Network SA
 http://osbn.inetd.com.au/

Open Source Industry Australia
 http://osia.net.au/
