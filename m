Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUG1J10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUG1J10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUG1J10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:27:26 -0400
Received: from math.ut.ee ([193.40.5.125]:58008 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266849AbUG1J1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:27:24 -0400
Date: Wed, 28 Jul 2004 12:19:42 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: trini@kernel.crashing.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: How to debug 2.6 PReP boot hang?
Message-ID: <Pine.GSO.4.44.0407281213400.6874-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Motorola Powerstack II Pro4000 that has PReP and OF and is not
booting in 2.6. I hangs very early, the display stays in OF graphics
mode and nothing is printed. So it does not reach vga_init in
load_kernel, and I'm not sure it even reaches load_kernel.

What is the best suggestion to debugging this? I have serial cable and
could output chars there but what is the platform-specific code snippet
that should output a char on serial port?

-- 
Meelis Roos (mroos@linux.ee)

