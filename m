Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVB1Vts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVB1Vts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVB1Vtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:49:47 -0500
Received: from mail.bencastricum.nl ([213.84.203.196]:8973 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S261755AbVB1VtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:49:14 -0500
Message-ID: <007801c51ddf$271d95d0$0602a8c0@links>
From: "Ben Castricum" <lk@bencastricum.nl>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Fw: 2.6.11-rc4 doubles CPU temperature
Date: Mon, 28 Feb 2005 22:47:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: lk@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some weird reason, 2.6.11-rc4 up to the current BK tree about doubles my
CPU temperature from 20 degrees Celcius to 40 while everything else is
unchanged (load/processes/config). The system does seem a bit more sluggish,
but that may just be a feeling. A cat /proc/cpu gives me

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 475.100
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 940.03

and my .config can be found at

http://www.bencastricum.nl/.config

I haven't got a clue on how to analyse this problem so I really appreciate
any info or suggestions I get. Please help me.

Cheers,
Ben

 

