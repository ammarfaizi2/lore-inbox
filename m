Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVEBVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVEBVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVEBVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:13:26 -0400
Received: from guru.webcon.ca ([216.194.67.26]:57504 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S261776AbVEBVNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:13:22 -0400
Date: Mon, 2 May 2005 17:13:15 -0400 (EDT)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: pavel@suse.cz
Subject: Q: swsusp with S5 instead of S4?
Message-ID: <Pine.LNX.4.62.0505021701090.14807@light.int.webcon.net>
Organization: "Webcon, Inc"
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using swsusp on my new HP dv1000 notebook. In general most everything
works just fine, in terms of general computing anyways, after resume.

However, some of the ancilary functions, such as LCD brightness, RF kill
switch, and volume mute button do not work after resuming.

Figuring that some hardware parameters were not being restored, I verified
that by forcing a cold boot (boot up to GRUB, issue the 'halt' command to
power off, then power on again and let the kernel resume from swsusp),
everything works perfectly again just as it should because the BIOS takes
care of the initialisation then, which it normally skips after a soft-off/S4.

Asside from trying to figure out exactly what hardware parameteres are not
being saved/restored, I'm happy to let the BIOS initialise those things.
But, I need a way to perform a normal power-off/S5 after swsusp instead of a
soft-off/S4 so that I don't have to go though the double-grub-boot process
every time. Can this be done?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
  Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
  imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
     *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
