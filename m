Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVJMBBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVJMBBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVJMBBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:01:00 -0400
Received: from fmr22.intel.com ([143.183.121.14]:49801 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964840AbVJMBA7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:00:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: processor module locks up hyperthreading enabled machine
Date: Wed, 12 Oct 2005 17:59:52 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005FDFBEA@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: processor module locks up hyperthreading enabled machine
Thread-Index: AcXPdEr+vTtzsYw0RV2j/yVa1KiAMAAG+jMg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Reinhard Nissl" <rnissl@gmx.de>, <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 13 Oct 2005 00:59:57.0451 (UTC) FILETIME=[6E1CB5B0:01C5CF91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) Does this problem go way if you boot with maxcpus=1?
2) Does the problem go away if you not load the acpi processor module?

Looks somewhat similar to
http://bugzilla.kernel.org/show_bug.cgi?id=5331

Thanks,
-Venki

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Reinhard Nissl
>Sent: Wednesday, October 12, 2005 2:30 PM
>To: linux-kernel@vger.kernel.org
>Subject: processor module locks up hyperthreading enabled machine
>
>Hi,
>
>I have this problem here on my system since starting to use kernel 
>2.6.13's release candidats. Attached you'll find the console output of 
>SuSE kernels 2.6.13 (OpenSuSE 10.0) and 2.6.13.2 (OpenSuSE 10.1). The 
>latter is "identical" to the output of a self compiled kernel 
>2.6.14-rc4, with the .config taken from 2.6.13.2's /proc/config.gz.
>
>How can I further assist in solving this issue?
>
>Bye.
>-- 
>Dipl.-Inform. (FH) Reinhard Nissl
>mailto:rnissl@gmx.de
>
