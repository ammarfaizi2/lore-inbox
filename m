Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTB1Woy>; Fri, 28 Feb 2003 17:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268229AbTB1Woy>; Fri, 28 Feb 2003 17:44:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15249 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265578AbTB1Wox>; Fri, 28 Feb 2003 17:44:53 -0500
Date: Fri, 28 Feb 2003 14:43:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <374420000.1046472228@flay>
In-Reply-To: <20010101052723.GB22212@krispykreme>
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Alpha is supported too... (as least I saw the kernel part go in)
> 
> sparc64 and ppc64 too, but only timer tick profiling so far.

I need the magic incantation for oprofile for these then ...

Actually, better still, we need a wrapper script that works out this
from /proc/cpuinfo and auto-sets it up for you, if someone who knows
enough about different Pentium types knows how ... I'm happy to go
write it if it's easy to detect ...

My laptop says: 

model name      : Pentium III (Coppermine)

but a list of pattern matches from someone (or list of people) who
know how this works would be very helpful (ie matching up cpuinfo
to magic incantation to oprofile).

M.

