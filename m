Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUJBDq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUJBDq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 23:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUJBDq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 23:46:27 -0400
Received: from relay.pair.com ([209.68.1.20]:15627 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267250AbUJBDqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 23:46:25 -0400
X-pair-Authenticated: 64.230.138.183
Date: Fri, 1 Oct 2004 23:46:24 -0400
From: Geoff Oakham <oakhamg@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] iRiver ifp filesystem driver
Message-ID: <20041002034624.GA14619@mbl.ca>
Reply-To: Geoff Oakham <oakhamg@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://prdownloads.sourceforge.net/ifp-driver/iriverfs-r0.1.0.0pre6.patch.gz?download

Hello,

This is a filesystem interface for iRiver "IFP" (flash-based) mp3
players that aren't USB mass storage devices.  It's been [successfully]
tested by ten volunteers on eleven systems using a variety of different
kernel configurations.  (Specifically, both with and without SMP,
PREEMPT.) The distribution of devices and computers used in testing
follows:

device models:

        1x IFP-1xx
        3x IFP-3xx
        1x IFP-5xx
        1x IFP-7xx
        4x IFP-8xx

arch:
        5x single IA32
        1x single IA32 - (HT)
        3x single AMD32
        1x dual   AMD32
        1x single AMD64


No testing was done on big-endian or other non-x86 system.  There was no
placebo control.  Reported side-effects included memory loss, fatigue,
auditory disturbances, hangover, chest pain and dizziness.  This driver
may not be right for everyone; check with your system administrator for
details.

As this is my first kernel hack, I'd appreciate any and all
feedback/suggestions/flames.  Please CC me on replies.

Cheers and thanks in advance,

Geoff

Ps. the patch is against 2.6.8.1, but it's reported to work on 2.6.3.

