Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbUKRCKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUKRCKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKRCEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:04:45 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:23256 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262379AbUKRCDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:03:36 -0500
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] prefer TSC over PM Timer
References: <88056F38E9E48644A0F562A38C64FB60035C613D@scsmsx403.amr.corp.intel.com>
	<Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 18 Nov 2004 03:01:17 +0100
In-Reply-To: <Pine.LNX.4.61.0411161738370.13681@twinlark.arctic.org> (dean
 gaudet's message of "Tue, 16 Nov 2004 17:50:42 -0800 (PST)")
Message-ID: <m3y8gz3ogi.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> writes:

> i know that all p3, p-m, p4, k8 and efficeon have local APIC,

Some Celeron P3s (the one in my notebook for example) have no L-APIC:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 6
cpu MHz         : 597.367
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1179.64
-- 
Krzysztof Halasa
