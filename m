Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbTHUA4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTHUA4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:56:33 -0400
Received: from [66.241.84.54] ([66.241.84.54]:1920 "EHLO bigred.russwhit.org")
	by vger.kernel.org with ESMTP id S262350AbTHUA4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:56:32 -0400
Date: Wed, 20 Aug 2003 17:54:15 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: module char_10_135
Message-ID: <Pine.LNX.4.53.0308201736040.178@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During boot-up, and just after the setting the clock line, noticed the
following line:

modeprobe: FATAL: module char_10_135 not found

First noticed this a few revisions ago. The contents of directory
/lib/modules/2.6.0-test3-bk8/kernel/drivers/char:

agp/  genrtc.ko  hw_random.ko  lp.ko  rtc.ko

hmm, long shot, but perhaps this bug is related to not auto-loading
module lp?

  Russ
