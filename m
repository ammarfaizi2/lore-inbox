Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKWMbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKWMbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKWMbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:31:31 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:26673 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S1750743AbVKWMba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:31:30 -0500
Message-ID: <4384611D.5020808@blueyonder.co.uk>
Date: Wed, 23 Nov 2005 12:31:25 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-git latest build broken on UP x86-64
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Nov 2005 12:32:21.0382 (UTC) FILETIME=[F3294260:01C5F029]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
 > Works for me with -git2 and defconfig changed to UP. config please 
and last changeset.
 >
 > -Andi

SuSE 10.0 x86_64 UP 2.6.15-rc2-git3. As previously posted, with -git2 a 
successful build depended on ext3 being configured, but this error was 
not seen.
   CC      arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.o
arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c: In function 
‘set_mtrr’:
arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: 
‘ipi_handler’ undeclared (first use in this function)
arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: (Each 
undeclared identifier is reported only once
arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: for 
each function it appears in.)
make[2]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.o] Error 1
make[1]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr] Error 2
make: *** [arch/x86_64/kernel] Error 2
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks
