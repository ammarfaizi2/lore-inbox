Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUBHQke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUBHQke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:40:34 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:47703 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263832AbUBHQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:40:18 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Date: Sun, 8 Feb 2004 13:40:22 +0000
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402081340.22752.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.6.0 to 2.6.3-rc1 (include -pre,-rc, -kb) all still occurs: 
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.

I tried:
------------------------------
apm on/off
acpi on/off
apic on/off 
preempt on/off 
psmouse.proto=bare
psmouse.proto=imps
psmouse.proto=exps
--------------------------------
/etc/X11/XF86Config 
        Option      "Protocol" "ImPS/2"
        Option      "Device" "/dev/input/mice"
---------------------------------
/etc/X11/XF86Config 
        Option      "Protocol" "PS/2"
        Option      "Device" "/dev/input/mice"
---------------------------------
/etc/X11/XF86Config 
        Option      "Protocol" "ImPS/2"
        Option      "Device" "/dev/psaux"
---------------------------------
/etc/X11/XF86Config 
        Option      "Protocol" "PS/2"
        Option      "Device" "/dev/psaux"
---------------------------------

I read several others threads about, but anything propose by that not solve problem!



