Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbRCIAqf>; Thu, 8 Mar 2001 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRCIAqZ>; Thu, 8 Mar 2001 19:46:25 -0500
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:19772 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S130386AbRCIAqL>; Thu, 8 Mar 2001 19:46:11 -0500
Date: Thu, 8 Mar 2001 16:41:12 -0800
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.2-ac14 in vmware - hangs
Message-ID: <20010308164112.A26411@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using VMware to test a linux install
and since I have upgraded to 2.4.2-ac14
the VM locks up right after:

calibrating APIC timer ...
..... CPU clock speed is 1152.4771 MHz.
..... host bus clock speed is 0.0000 MHz.
cpu: 0, clocks: 0, slice: 0


The last line is where it locks up...  Its
kind of suspicious that the clock speeds are wrong,
The CPU speed should be 733 MHz (unless VMWare is using
both my CPU's?) and I am almost 100% sure that the
bus speed should not be 0.0000 MHz!

Can anyhone help me with this?
Is it a bug on my part or what?

Thanks,
Mike
-- 
