Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270438AbTG1SYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270439AbTG1SYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:24:10 -0400
Received: from 209-5-247-146.mb.skyweb.ca ([209.5.247.146]:51108 "EHLO
	telecomoptions.com") by vger.kernel.org with ESMTP id S270438AbTG1SYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:24:08 -0400
Subject: sound static on VIA 8233 southbridge using ALSA drivers
From: Dave Poirier <dpoirier@telecomoptions.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Jul 2003 13:38:55 -0500
Message-Id: <1059417535.331.4.camel@grid>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.6 test1 and test2

using the 8233 ALSA drivers a lot of static can be heard, replacing the
ALSA drivers by the VT82Cxxx OSS driver fixes the static problem.

  Bus  0, device  17, function  5:
  Multimedia audio controller: VIA Technologies, In VT8233 AC97 Audio Co
(rev 80).
  IRQ 11.
  I/O at 0xd800 [0xd8ff].

Is there any existing patch/solution for this problem? (please CC answer
as I am not subscribed to lkml).

-eks


