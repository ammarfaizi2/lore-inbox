Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSJHXgC>; Tue, 8 Oct 2002 19:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSJHXfd>; Tue, 8 Oct 2002 19:35:33 -0400
Received: from mx15.sac.fedex.com ([199.81.197.54]:47628 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261575AbSJHXe4>; Tue, 8 Oct 2002 19:34:56 -0400
Date: Wed, 9 Oct 2002 07:39:37 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: bug 2 cpus shows as 4 cpus
Message-ID: <Pine.LNX.4.42.0210090733280.367-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/09/2002
 07:40:34 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/09/2002
 07:40:36 AM,
	Serialize complete at 10/09/2002 07:40:36 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.4.20-pre9 on DELL server with Xeon dual processors, but
/proc/cpuinfo shows not 2, but "4" cpus!

The bogomips semms to indicate 2 cpus. (3971.48 is about 2GHz x 2).

Is this problem related to Xeon? I've other SMP boxes with P3, but they
reports correctly 2 cpus.

thanks,
Jeff.




Here's the last cpu ...

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1988.912
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3971.48




