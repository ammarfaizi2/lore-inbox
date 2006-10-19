Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422978AbWJSOAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWJSOAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWJSOAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:00:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:9272 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1422978AbWJSOAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:00:12 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="148959418:sNHT1624185521"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino: ENODEV
Date: Thu, 19 Oct 2006 07:00:07 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A223@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino: ENODEV
Thread-Index: Acby6q9Mc0GIE1lDRieZtRgqqXZU/AAnBroQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jiri Slaby" <jirislaby@gmail.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 19 Oct 2006 14:00:09.0009 (UTC) FILETIME=[E33ADA10:01C6F386]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How about acpi-cpufreq? Does it work?

Thanks,
Venki 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jiri Slaby
>Sent: Wednesday, October 18, 2006 12:01 PM
>To: Linux kernel mailing list
>Cc: linux-acpi@vger.kernel.org
>Subject: speedstep-centrino: ENODEV
>
>Hi!
>
>How is it possible to find out whether or not 
>speedstep-centrino is supported. I 
>have
>processor       : 0
>vendor_id       : GenuineIntel
>cpu family      : 6
>model           : 13
>model name      : Intel(R) Pentium(R) M processor 1.60GHz
>stepping        : 6
>cpu MHz         : 1600.149
>cache size      : 2048 KB
>fdiv_bug        : no
>hlt_bug         : no
>f00f_bug        : no
>coma_bug        : no
>fpu             : yes
>fpu_exception   : yes
>cpuid level     : 2
>wp              : yes
>flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr 
>pge mca cmov pat 
>clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
>bogomips        : 3201.52
>
>processor, but speedstep-centrino returns ENODEV because of 
>lack of _PCT et al 
>entries in DSDT (http://www.fi.muni.cz/~xslaby/sklad/adump). 
>It is possible to 
>hard-code that values to speedstep-centrino as for banias cpus 
>or use corrected 
>DSDT that will contain _PCT, _PSS and _PPC, but where may I 
>obtain these values?
>
>This is Asus M6R notebook, some DSDT parts of this piece of HW 
>are really ugly 
>(problems with acpi some time ago).
>
>I may use p4-clockmod (and it points me to speedstep-centrino 
>module), but if I 
>am correct, it doesn't save battery life?
>
>thanks,
>-- 
>http://www.fi.muni.cz/~xslaby/            Jiri Slaby
>faculty of informatics, masaryk university, brno, cz
>e-mail: jirislaby gmail com, gpg pubkey fingerprint:
>B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
