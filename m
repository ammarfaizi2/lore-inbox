Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRIDWSN>; Tue, 4 Sep 2001 18:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269651AbRIDWSE>; Tue, 4 Sep 2001 18:18:04 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:63061 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S269646AbRIDWRu>; Tue, 4 Sep 2001 18:17:50 -0400
Message-ID: <3B955234.2040204@chello.nl>
Date: Wed, 05 Sep 2001 00:14:12 +0200
From: Gerbrand van der Zouw <g.vanderzouw@chello.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: Patrick Chase <pchase2@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Status of the VIA KT133a and 2.4.x debacle?
In-Reply-To: <999493106.15509.33.camel@homebase.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Chase wrote:


> Are you enabling or disabling bank interleaving with the new BIOS?


As it turned out, the oopses are not correlated with the bank 
interleaving. I can turn the feature on and off and system stability 
remains the same (which is good enough to write this mail under X and 
compile a kernel).
The other features that this BIOS upgrade (Award v. 2.9) includes are 
(from the MSI site):

-Add Bank Interleave item in the BIOS Chipset setup
-Adjust Vcore Voltage Sensitivity on Hardware Monitor
-Show CPU L1 and L2 cache size
-Don't Display Ghz for AMD K7 CPU
-Fixed that WD WD400BB-00AUA1 HDD fail in FDISK with nVidia Geforce2 AGP Card


In fact I do have a nVidia Geforce2 card. Another hypothesis is that the 
last fix, also fixes the oopses.

Tomorrow I will flash the BIOS back to 2.7 and see if I get the system 
back to the previous, unstable state.

Regards,

Gerbrand van der Zouw


