Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbTFWRPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbTFWRPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 13:15:24 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:51411 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id S266075AbTFWRPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 13:15:21 -0400
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.22-pre1] menuconfig oddity
Date: Mon, 23 Jun 2003 19:27:57 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306231927.57946.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first I want to say that I could compile 2.4.22-pre1 without problems and 
everything works fine for 4 hours on a desktop machine with little load.

However, I had a small problem during my installation:

After the first compilation and reboot, I started menuconfig again and all 
subentries of "ACPI support" were gone. I took a brief look at the .config, 
but there were at least some entries.

So I ignored this, changed my config via menuconfig, recompiled and rebooted 
and ACPI was gone ;-(

After copying my old config and "make oldconfig", everything was back to 
normal. Unfortunately i wasn't able to reproduce this error.

I just wanted to let you know...

 Jan-Hinnerk

