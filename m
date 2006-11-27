Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756498AbWK0EC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbWK0EC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbWK0EC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 23:02:58 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:56229 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1756498AbWK0EC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 23:02:58 -0500
Message-ID: <456A73DA.7040601@wolfmountaingroup.com>
Date: Sun, 26 Nov 2006 22:12:58 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.18 Memory Error (mapping)/Reboot with 8GB of memory 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running with 8GB of memory, dual Xeon system on a 2.6.18 kernel, the 
following error occurs when the system finally exhausts
physical memory prior to using swap space (results in a reboot of the 
system) :

Nov 26 04:10:00 gadugi syslogd 1.4.1: restart.
Nov 26 10:33:24 gadugi kernel: Non-Fatal Error DRAM Controler
Nov 26 10:33:24 gadugi kernel: Test row 1 Table 0 255 2 255 4 255 6 255
Nov 26 10:33:24 gadugi kernel: Test computed row 8
Nov 26 10:33:24 gadugi kernel: MC0: row 1 not found in remap table
Nov 26 10:33:24 gadugi kernel: EDAC MC0: CE page 0x17d8eb, offset 0x0, 
grain 0, syndrome 0x7804, row 1, channel 1, label "": e752x CE
Nov 26 16:20:09 gadugi dhclient: DHCPREQUEST on eth0 to 68.87.66.13 port 67
Nov 26 16:20:09 gadugi dhclient: DHCPACK from 68.87.66.13
Nov 26 16:20:09 gadugi dhclient: bound to 67.177.44.96 -- renewal in 
94902 seconds

Jeff
