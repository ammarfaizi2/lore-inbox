Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSLVRjb>; Sun, 22 Dec 2002 12:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSLVRjb>; Sun, 22 Dec 2002 12:39:31 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17342 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265130AbSLVRjb>; Sun, 22 Dec 2002 12:39:31 -0500
Date: Sun, 22 Dec 2002 09:47:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH][2.4]  generic support for systems with more than 8 CPUs
 (2/2)
Message-ID: <36680000.1040579247@titus>
In-Reply-To: <20021222121717.GH25000@holomorphy.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com>
 <20021222121717.GH25000@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
> table's presence, in particular if there's a matching string in the 8B
> OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
> probably a line or two's worth of change to mpparse.c and declaring a
> variable for clustered_apic_mode. If it were difficult to detect, I
> wouldn't have suggested implementing it (though do so at your leisure). =)
>
> I still think this is 2.5 material + backport once it gets testing there.

I think there are still some things around that are switched on #defines
for NUMA-Q. Also older machines will probably say Sequent instead of IBM
in the OEM table. Would need some testing ...

M.

