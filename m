Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275897AbSIULHf>; Sat, 21 Sep 2002 07:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275898AbSIULHf>; Sat, 21 Sep 2002 07:07:35 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:49026 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S275897AbSIULHf>; Sat, 21 Sep 2002 07:07:35 -0400
Date: Sat, 21 Sep 2002 13:06:41 +0200
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: cpufreq for 2.5.37 now available
Message-ID: <20020921130641.A21823@brodo.de>
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

Changes since the version for 2.5.36:
- longrun.c: use LRTI for lowest frequency detection if available
- p4-clockmod.c: allow to run rdmsr/wrmsr on both hyperthreading cores

complete patch for kernel 2.5.37:
http://www.brodo.de/cpufreq/cpufreq-2.5.37-1.gz

step-by-step patches for kernel 2.5.37:
http://www.brodo.de/cpufreq/cpufreq-2.5.37-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.37-i386-core-1
http://www.brodo.de/cpufreq/cpufreq-2.5.37-i386-drivers-1
http://www.brodo.de/cpufreq/cpufreq-2.5.37-doc-1
http://www.brodo.de/cpufreq/cpufreq-2.5.37-24api-1

backport to kernel 2.4.19/2.4.20-pre7:
http://www.brodo.de/cpufreq/cpufreq-2.4.19-3.gz
http://www.brodo.de/cpufreq/cpufreq-2.4.20-pre7-3.gz

This cpufreq version is included in 2.4.-ac patchsets since
2.4.20-pre7-ac1, a few updates for -ac2 and -ac3 can be found here:
http://www.brodo.de/cpufreq/cpufreq-2.4.20-pre7-ac2-1

Comments welcome; please ensure that the cpufreq development list at
cpufreq@www.linux.org.uk receives a copy of all comments.


	Dominik
