Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314621AbSD2St4>; Mon, 29 Apr 2002 14:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314625AbSD2Stz>; Mon, 29 Apr 2002 14:49:55 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:58824 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314621AbSD2Sty>; Mon, 29 Apr 2002 14:49:54 -0400
Message-Id: <200204291849.NAA23906@popmail.austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Hyperthreading and physical/logical CPU identification
Date: Mon, 29 Apr 2002 13:31:53 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I would like to know if there is any way to confirm that I have 
hyperthreading enabled, and my P4 CPUs are hyperthreaded.  Actually, from 
something like /proc/cpuinfo, I'd like to figure out if I am seeing 2/4 
physical/logical processors, as a result from hyperthreading, or 4/4 
physical/logical processors with no hyperthreading.  I know, "If it's double 
the number of physical processors, well you have hyperthreading enabled."  
The problem is, I have 4 physical processors, but kernel.org kernels so far 
do not recognize all of them.  2.4.18 will find 3, while 2.5.11 will find 
only 2 (BIOS hyperthreading support off, no acpismp=force).  However, on 
2.5.11, if I enable hyperthreading (thru BIOS and acpismp=force, I see 4 
processors.  

I would very much like to believe that in this configuration, I am only 
running on 2 physical, 4 logical processors, but I am getting a 31% 
improvement (netbench) when hyperthreading is enabled.  Thats why I want to 
confirm I am really only using 2 physical, 4 logical processors.  Is there 
any way I can do this? (dmesg? /proc/cpuinfo?)

Thanks

Andrew Theurer
