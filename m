Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTJKUYV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 16:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTJKUYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 16:24:20 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:42411 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263386AbTJKUYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 16:24:14 -0400
Date: Sat, 11 Oct 2003 15:24:11 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: retaining use of the mouse wheel with "psmouse_noext=1"?
Message-ID: <20031011202411.GA1397@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to use the "psmouse_noext=1" option to psmouse.ko, in order to
keep the pointer from going stark-raving mad[1] when I use my KVM
switch.  Unfortunately, this seems to squash the use of the mouse wheel
for scrolling (it still works as a 3rd button), which is a feature I'd
really like to retain.  Is there any way to keep the wheel fully
functional when using this option (or otherwise fix the KVM issue)? 
It's a Belkin SOHO 4-port switch, if that makes a difference.


[1] The mouse pointer jumps wildly around the screen at the slightest
nudge, while simultaneously doing a cut/paste of every bit of text in
sight.  The only way to reset things to normal seems to be an
unload/reload of the psmouse module.
