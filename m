Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTDINuY (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTDINuY (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 09:50:24 -0400
Received: from WARSL401PIP6.highway.telekom.at ([195.3.96.93]:25647 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id S263413AbTDINuX (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 09:50:23 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.20 on a 4 MB Laptop
Date: Wed, 9 Apr 2003 16:01:55 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304091601.55821.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I currently try installing Linux on an old IBM Laptop. (IBM Thinkpad 340, 
486SLC 25/50 from 1994). The laptop only has 4 MB RAM, so I installed a 
simple Linux distribution on a better computer, recompiled Linux 2.4.20 and 
stripped out everything I could (with menuconfig): No networking. FPU 
emulation. The only "luxury" I left is "ext3" - perhaps this uses a lot of 
memory?

Well - anyway, the kernel boots but right stops after:
INIT: Entering runlevel:3

The next line is:
INIT: open(/dev/console): Input/output error
INIT: Id "2" respawning too fast: disabled for 5 minutes
...

That's it.

What I want to know is if this happens just because of the low memory (4MB) or 
if there is another reason for this behaviour.

What do you think: What are the minimum requirements for Linux on such a 
laptop (no X, of course, very simple setup): 8MB, 12MB?

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

