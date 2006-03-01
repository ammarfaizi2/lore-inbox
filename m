Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWB1XYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWB1XYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWB1XYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:24:12 -0500
Received: from fmr21.intel.com ([143.183.121.13]:4055 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932717AbWB1XYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:24:12 -0500
Message-Id: <20060301001557.318047000@araj-sfield>
Date: Tue, 28 Feb 2006 16:15:57 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 0/5] ACPI based physical CPU hotplug support for x86_64 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi/Andrew

Here are a set of patches to implement physical cpu hotplug for x86_64 arch.

Physical cpu hotplug support is already available for ia64, these set of
patches extend support for x86_64 as well.

Patches are split as follows. Please help the first 3 patches stage
in -mm before considering for mainline inclusion. The last 2 patches are
purely for testing. 

1. remove-processor-entries-on-eject - Minor bugfix to current base code.
2. remove-unused-lapic-entry		 - Remove unnecessary lapic definition
3. x86_64-physical-cpu-hotplug.patch - Physical cpu hotplug support for x86_64

The following two patches are not for mainline inclusion. They exist so 
we could test the code paths to test physical hotplug without need for a 
platform that is capable of hotplug. 

Procedure to do this is included in sci emulate patches.
4. x86_64-limit-cpus				 - Limit cpus present to emulate Physical
									   hotplug.
5. sci_emu.patch					 - Code to emulate SCI notify on a object.

Cheers,
ashok

