Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSJZAlN>; Fri, 25 Oct 2002 20:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSJZAlN>; Fri, 25 Oct 2002 20:41:13 -0400
Received: from smtp07.iddeo.es ([62.81.186.17]:7659 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S261718AbSJZAlM>;
	Fri, 25 Oct 2002 20:41:12 -0400
Date: Sat, 26 Oct 2002 02:47:26 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021026004726.GC1676@werewolf.able.es>
References: <F2DBA543B89AD51184B600508B68D4000ECE70C8@fmsmsx103.fm.intel.com> <20021026004320.GA1676@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021026004320.GA1676@werewolf.able.es>; from jamagallon@able.es on Sat, Oct 26, 2002 at 02:43:20 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.26 J.A. Magallon wrote:
>
>processor : 0  processor : 2  processor : 4  processor  : 6 
>package   : 0  package   : 0  package   : 0  package    : 0  
>core      : 0  core      : 1  core      : 2  core       : 3  
>
>processor : 1  processor : 3  processor : 5  processor  : 7 
>package   : 1  package   : 1  package   : 1  package    : 1  
>core      : 0  core      : 1  core      : 2  core       : 3  
>

Er, while you're at it, would it be worthy to add ad:

node:	x

for NUMA boxes ?

(just a silly idea)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam2 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
