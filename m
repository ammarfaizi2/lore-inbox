Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264139AbSIVMhJ>; Sun, 22 Sep 2002 08:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264156AbSIVMhJ>; Sun, 22 Sep 2002 08:37:09 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:24969 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264139AbSIVMhI>; Sun, 22 Sep 2002 08:37:08 -0400
Date: Sun, 22 Sep 2002 14:39:00 +0200
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Cc: hpa@zytor.com
Subject: cpufreq for 2.5.38 now available
Message-ID: <20020922143900.A1098@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Updated patches for CPU frequency and voltage scaling support are now
available at

http://www.brodo.de/cpufreq/

changes from cpufreq-2.5.37-1 to cpufreq-2.5.38-1:
--------------------------------------------------
- longrun.c:   use LRTI for detecting the highest possible frequency
			(many thanks to hpa for his help wrt longrun.c)
- speedstep.c: allow to set to SPEEDSTEP_HIGH, correct dprintk statement
			(Luciano Campal Vazquez)

complete patch for kernel 2.5.38:
http://www.brodo.de/cpufreq/cpufreq-2.5.38-1.tar.gz

step-by-step patches for kernel 2.5.38:
http://www.brodo.de/cpufreq/cpufreq-2.5.38-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.38-i386-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.38-i386-drivers-1
http://www.brodo.de/cpufreq/cpufreq-2.5.38-doc-1
http://www.brodo.de/cpufreq/cpufreq-2.5.38-24api-1

backport to kernel 2.4.19/2.4.20-pre7:
http://www.brodo.de/cpufreq/cpufreq-2.4.19-4.gz
http://www.brodo.de/cpufreq/cpufreq-2.4.20-pre7-4.gz

This cpufreq version is included in 2.4.-ac patchsets since
2.4.20-pre7-ac1, a few updates for -ac3 can be found here:
http://www.brodo.de/cpufreq/cpufreq-2.4.20-pre7-ac3-1

Comments welcome; please ensure that the cpufreq development list at
cpufreq@www.linux.org.uk receives a copy of all comments.


	Dominik
