Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbUCCTiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUCCTiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:38:20 -0500
Received: from p10068181.pureserver.de ([217.160.75.209]:5392 "EHLO
	www.kuix.de") by vger.kernel.org with ESMTP id S262558AbUCCTiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:38:19 -0500
Message-ID: <4046342B.6050302@kuix.de>
Date: Wed, 03 Mar 2004 20:38:19 +0100
From: Kai Engert <kaie@kuix.de>
Reply-To: kai.engert@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030721 wamcom.org
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CONFIG_USB_HIDDEV=m (fedora config) isn't converted to y
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if you consider the following a bug in the kernel build system.

- Using a stock Fedora Core 1 2.4.x kernel, my USB mouse works in X.
- I copied the FC1 .config to a 2.4.25 kernel, went through make 
menuconfig, and compiled.
- The mouse no longer worked in X

I noticed the hiddev driver is no longer being compiled at all.
It seems "m" (as used by FC1 config) is not (or no longer) a valid 
compile option for hiddev.
I changed it to "y", compiled again, and now the mouse works with 2.4.25

Should "make menuconfig" automatically detect and change invalid m/y 
settings to valid ones?

Regards,
Kai

