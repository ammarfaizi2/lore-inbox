Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSLTRJ5>; Fri, 20 Dec 2002 12:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLTRJ5>; Fri, 20 Dec 2002 12:09:57 -0500
Received: from holomorphy.com ([66.224.33.161]:39878 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262807AbSLTRJ4>;
	Fri, 20 Dec 2002 12:09:56 -0500
Date: Fri, 20 Dec 2002 09:16:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Message-ID: <20021220171658.GE9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C0101F55D@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F55D@usslc-exch-4.slc.unisys.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 09:46:19AM -0600, Van Maren, Kevin wrote:
> I mostly work on our 16-32p IA64 machines.  Natalie or someone else will
> have to comment on the clustered-apic code.

Okay, that's not too big a deal. I didn't expect you'd field it directly.


On Fri, Dec 20, 2002 at 09:46:19AM -0600, Van Maren, Kevin wrote:
> Also, as a clarification, our 32-processor systems are NOT NUMA: there
> is a full non-blocking crossbar to memory.  So clustered APIC support
> should not be dependant on NUMA.

That one's easy to fix (and apparently for you to spot despite not
actually working on the things).


Thanks,
Bill
