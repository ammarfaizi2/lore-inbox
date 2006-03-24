Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423133AbWCXFDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423133AbWCXFDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423134AbWCXFDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:03:05 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:26758 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1423133AbWCXFDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:03:04 -0500
Message-ID: <44237D87.70300@tlinx.org>
Date: Thu, 23 Mar 2006 21:03:03 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Security downgrade? CONFIG_HOTPLUG required in 2.6.16? 
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this config'ed out in 2.6.15 for machine that didn't have
any hotpluggable devices.  It is also configured with all the
modules it needs and has kernel-module loading disabled.

What has changed in 2.6.16 that my "static" machine now
needs hotplugging?  As I understand it, hotplugging requires 
application-level support code (in /etc/) and a special
application level "demon" to run in order to support these
requests.

I'd prefer my kernel not to be dependent on a run-time demon
to load "arbitrary" (user defined) segments of code that could
come from any source -- usually outside the vanilla kernel tree.

If I don't want a specific kernel or machine to be dynamically
reconfigurable after boot, why do I need to build in a mechanism for
runtime loading of modules?

Linda

