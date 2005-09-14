Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVINSQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVINSQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbVINSQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:16:08 -0400
Received: from er-systems.de ([217.172.180.163]:47628 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S932423AbVINSQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:16:07 -0400
Date: Wed, 14 Sep 2005 20:16:10 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: linux-kernel@vger.kernel.org
Subject: forced to CONFIG_PM=y
Message-ID: <Pine.LNX.4.61.0509142002130.22437@er-systems.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

on one computer, which I wanted to switch from 2.6.13 to 2.6.14-rc1 I was
forced to use CONFIG_PM, look:

thomas@tv2:~/linux-2.6.14-rc1> zgrep CONFIG_PM /proc/config.gz 
# CONFIG_PM is not set
thomas@tv2:~/linux-2.6.14-rc1> zcat /proc/config.gz > .config 
thomas@tv2:~/linux-2.6.14-rc1> make oldconfig
...
*
* Power management options (ACPI, APM)
*
Power Management support (PM) [Y/?] y
  Power Management Debug Support (PM_DEBUG) [N/y/?] (NEW) 


I never had question if I want to have CONFIG_PM, the "y" was already 
there.


Is this wanted?


      Thomas


