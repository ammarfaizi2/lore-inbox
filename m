Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTEUWyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTEUWyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:54:32 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:49538
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262318AbTEUWyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:54:31 -0400
Date: Wed, 21 May 2003 18:56:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, "" <haveblue@us.ibm.com>,
       "" <wli@holomorphy.com>, "" <arjanv@redhat.com>,
       "" <pbadari@us.ibm.com>, "" <linux-kernel@vger.kernel.org>,
       "" <gh@us.ibm.com>, "" <johnstul@us.ibm.com>, "" <akpm@digeo.com>,
       "" <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
In-Reply-To: <200305210654.22987.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0305211856090.25777-100000@montezuma.mastecende.com>
References: <3014AAAC8E0930438FD38EBF6DCEB56402043344@fmsmsx407.fm.intel.com>
 <200305210654.22987.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, James Cleverdon wrote:

> It may be time to think about using the TPRs again, and see if HW interrupt 
> routing helps Arjan's test case.  Of course for any system using clustered 
> APIC mode, we will still need to decide which APIC cluster gets which IRQ....

You can build cpu masks of capable clusters easily, even for NUMAQ

	Zwane
-- 
function.linuxpower.ca
