Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbTAOSdU>; Wed, 15 Jan 2003 13:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTAOSdU>; Wed, 15 Jan 2003 13:33:20 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:43674 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S266852AbTAOSdT>; Wed, 15 Jan 2003 13:33:19 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD905@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Date: Wed, 15 Jan 2003 12:41:19 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Can these (MAX_IO_APICS, MAX_APICS) be moved to sub-arch too, instead of

Yes, pleeese! Without CLUSTERED_APIC I would have to re-define it in some
ugly way in subarch.

>Actually replacing CONFIG_X86_NUMA with CONFIG_NUMA ... and we could
>do (CONFIG_NUMA || CONFIG_BIGSMP) instead. But you're right, subarch
>would be much better if you can find a way.

With BIGSMP, we are still only allowed 16, whereus es7000 needs 256 of
each...
