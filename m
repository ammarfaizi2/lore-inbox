Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVI2QeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVI2QeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVI2QeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:34:19 -0400
Received: from gscsmtp.wustl.edu ([128.252.233.26]:25000 "EHLO
	gscsmtp.wustl.edu") by vger.kernel.org with ESMTP id S932220AbVI2QeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:34:18 -0400
Message-ID: <433C1787.4090001@watson.wustl.edu>
Date: Thu, 29 Sep 2005 11:34:15 -0500
From: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: em64t speedstep technology not supported in kernel yet?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

We recently had Intel give our company a roadmap presentation where they 
told us that their enhanced speedstep technology was supported by linux 
kernels 2.6.9+.  I have since tried to get cpufreq speedstep driver to 
work with no luck on our em64t Xeon 3.6g processors.  Intel even has a 
webpage describing the technology and how to get it working at url: 
http://www.intel.com/cd/ids/developer/asmo-na/eng/195910.htm?prn=Y

I made a bugzilla report to redhat [Bug 169290] and got a reply that 
none of the Xeon's were supported yet on speedstep because they cannot 
find documentation detailing the tables of frequencies these CPUs support.

The only processor I have had luck with so far is a 32-bit Xeon with the 
p4-clockmod driver(which does not appear to be present in the x86-64 
kernel).

Anyone have any knowledge regarding cpufreq and when the em64t's are 
going have a linux driver supporting the speedstep technology?  If it is 
an issue of Intel not providing the neccessary info, maybe I can press 
the issue with the gentlemen that came to my office and stated support 
was there already.

Thanks for any info and advice.  Please CC my on any replies since I am 
not on the list.

Rich Wohlstadter
Genome Sequencing Center
Washington Univ. of St. Louis
