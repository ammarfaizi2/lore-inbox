Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbTFLEAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 00:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbTFLEAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 00:00:10 -0400
Received: from main.gmane.org ([80.91.224.249]:50389 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264720AbTFLEAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 00:00:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: cpufreq on Pentium M
Date: Wed, 11 Jun 2003 23:13:26 -0500
Organization: Complete.Org
Message-ID: <87n0go3pcp.fsf@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:gosYgdp95NQY91k6KdjxFWlUBW4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running on a Thinkpad T40p laptop, which has a 1.6GHz Intel
Pentium M CPU (this is their "Centrino" CPU; *NOT* the same thing as
the Pentium 4 M).

I have tried 2.4.21-rc7-ac1, but it reports:

cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.

Yet my BIOS lets me configure SpeedStep for it by name.  Are there any
plans in the works for this?

While we're at it, I'm concerned that Linux is ignoring the sizable
cache available on this platform:

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 1598.686
cache size      : 0 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm
bogomips        : 3191.60

