Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTAJK7u>; Fri, 10 Jan 2003 05:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbTAJK7u>; Fri, 10 Jan 2003 05:59:50 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:385 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264878AbTAJK7p>;
	Fri, 10 Jan 2003 05:59:45 -0500
Date: Fri, 10 Jan 2003 11:05:47 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jamesclv@us.ibm.com, Jason Lunz <lunz@falooley.org>,
       linux-kernel@vger.kernel.org
Subject: Re: detecting hyperthreading in linux 2.4.19
Message-ID: <20030110110547.GC29190@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
	Jason Lunz <lunz@falooley.org>, linux-kernel@vger.kernel.org
References: <slrnb1rlct.g2c.lunz@stoli.localnet> <200301091337.04957.jamesclv@us.ibm.com> <15902.28835.127030.199073@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15902.28835.127030.199073@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 08:05:07AM +0100, Mikael Pettersson wrote:

 > If the kernel has sched_setaffinity() or some other way of binding a process
 > to a given CPU (as numbered by the kernel, which may or may not be related
 > to any physical CPU numbers), then this will do it: execute CPUID on each
 > CPU and check the initial APIC ID field. If you find one that's non-zero,
 > then HT is enabled.

That's a horrible way of reimplementing /dev/cpu/x/cpuid  8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
