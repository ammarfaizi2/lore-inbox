Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbTGKS5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTGKS4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:56:46 -0400
Received: from web13301.mail.yahoo.com ([216.136.175.37]:13189 "HELO
	web13301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264813AbTGKSFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:05:34 -0400
Message-ID: <20030711182015.71489.qmail@web13301.mail.yahoo.com>
Date: Fri, 11 Jul 2003 11:20:15 -0700 (PDT)
From: Ronald Jerome <imun1ty@yahoo.com>
Subject: generate-modprobe question and USB fatal error during INIT:-resending
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For soem reason it looks like my first post did not go
thru.  I am sending this again.  SOrry if it posts
twice

I unsubcribed from softhome.net and subscribed
with this address.  Softhome did not give me enough
space.


Anyhow I think I know what the problem is?  Its with
the modprobe.conf.

I updated both my mkinitrd and mod-utils with the aid
of Paul Nasrat.  I dunno if you know who he is.

Anyhow when I run "generate-modprobe.conf >
/etc/modprobe.conf

I see that the the sections for "usb-uhci" "mousedev"
and "keybdev".   Those are incorrect.  They should be
"uhci-hcd", "usbmouse" and "usbkbd".  Once I changed
the "usb-uhci" to "uhci-hcd"  at least the usb
installed ok but those changes I made for the mouse
and keyboard still does not work.

Is there something screwed up somewhere else?

If I rerun  "generate-modprobe.conf >
/etc/modprobe.conf

Everything defaults back to "usb-uhci", "mousedev" and
keybdev"?

WHy I am not sure.

Is there a fix for this to get the modprobe.conf to
correlate to the new kernel modules?


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
