Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUDLXxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 19:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbUDLXxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 19:53:34 -0400
Received: from web11304.mail.yahoo.com ([216.136.131.207]:42768 "HELO
	web11304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263174AbUDLXxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 19:53:32 -0400
Message-ID: <20040412235322.99636.qmail@web11304.mail.yahoo.com>
Date: Mon, 12 Apr 2004 16:53:22 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: S3 virge/Savage question
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this is off topic, but I'm at a loss at the moment and I'm hoping
someone here can help me.  I'm trying to add dualhead support (duoview)
to the xfree86/XORG savage and virge drivers for savage mx/ix and virge
mx.  I don't have databooks, but I found some incomplete info on the
virge mx and I've figured out how it's supposed to work for the most
part.  I can program both dot clocks and set the mode on both crtcs,
but I can't get the second crtc to actually display anything. when I
drive an output with crtc2, the attached device just goes into
powersave mode.  I'm guessing there must be an additonal "screen off"
bit or crtc2 enable bit I'm missing.  Is sr1 bit 5 (screen off) global,
or specific to crtc1? Also both dot clocks work so that doesn't seem to
be the issue.

CRTC  DCLK  Output      Result
---------------------------------------
crtc1 dclk1 FP/CRT/Both Works
crtc1 dclk2 FP/CRT/Both Works
crtc2 dclk1 FP/CRT/Both No signal
crtc2 dclk2 FP/CRT/Both No signal 

Additional info about how duoview works (what I've been able to figure
out):
http://www.botchco.com/alex/new-savage/savage/DUOVIEW.txt
Current status of my savage duoview code:
http://www.botchco.com/alex/new-savage/html/
Any help would be much appreciated. Please cc: me directly as I'm not
on linux-kernel.

Thanks,

Alex Deucher
http://dri.sourceforge.net/cgi-bin/moin.cgi/AlexDeucher

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
