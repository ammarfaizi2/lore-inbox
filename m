Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTGKR5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTGKRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:55:48 -0400
Received: from web13310.mail.yahoo.com ([216.136.173.222]:56851 "HELO
	web13310.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264551AbTGKRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:55:35 -0400
Message-ID: <20030711181014.15035.qmail@web13310.mail.yahoo.com>
Date: Fri, 11 Jul 2003 11:10:14 -0700 (PDT)
From: Ronald Jerome <imun1ty@yahoo.com>
Subject: generate-modprobe question and USB fatal error during INIT:
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I unsubribed "imunity@softhome.net"  and subscribed
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
