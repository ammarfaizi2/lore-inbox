Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275235AbTHMPX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275237AbTHMPX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:23:57 -0400
Received: from rosdorff.xs4all.nl ([213.84.29.108]:45956 "EHLO
	rosdorff.xs4all.nl") by vger.kernel.org with ESMTP id S275235AbTHMPXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:23:54 -0400
Date: Wed, 13 Aug 2003 17:23:53 +0200 (CEST)
From: Coen Rosdorff <coen@rosdorff.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: VM: killing process amavis
Message-ID: <Pine.LNX.4.44.0308131708570.29133-100000@rosdorff.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who can tell me something about this error in /var/log/messages:

Aug 13 10:12:51 rosdorff kernel: VM: killing process amavis
Aug 13 10:12:51 rosdorff kernel: swap_free: Unused swap offset entry 02000000

Memtest86: No errors.

Kernel: 2.4.21
Mem: 256MB
CPU: Intel PII 300Mhz

# cat /proc/swaps 
Filename                        Type            Size    Used    Priority
/dev/sda2                       partition       530136  44256   -1

# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  263229440 194764800 68464640        0 55820288 91078656
Swap: 542859264 45318144 497541120
MemTotal:       257060 kB
MemFree:         66860 kB
MemShared:           0 kB
Buffers:         54512 kB
Cached:          58248 kB
SwapCached:      30696 kB
Active:          90332 kB
Inactive:        74088 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       257060 kB
LowFree:         66860 kB
SwapTotal:      530136 kB
SwapFree:       485880 kB

