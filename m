Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbTBTUee>; Thu, 20 Feb 2003 15:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTBTUee>; Thu, 20 Feb 2003 15:34:34 -0500
Received: from holomorphy.com ([66.224.33.161]:54176 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266962AbTBTUee>;
	Thu, 20 Feb 2003 15:34:34 -0500
Date: Thu, 20 Feb 2003 12:42:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous	reboots)
Message-ID: <20030220204250.GC29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Chris Wedgwood <cw@f00f.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com> <1045776104.3790.34.camel@irongate.swansea.linux.org.uk> <6220000.1045772628@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6220000.1045772628@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, _A_ wrote:
>> You also need IRQ stacks to get down to 4K. The wrong pattern of ten
>> different IRQ handlers using a mere 200 bytes each will eventually
>> happen and eventually kill you otherwise.

On Thu, Feb 20, 2003 at 12:23:49PM -0800, Martin J. Bligh wrote:
> That's in Dave's patchset, and 4K stacks is a config option for now.

You might want to grab aeb's fully non-recursive pathwalking if
you really want to cut back the stack to 4KB, as well as fixing
whatever stackblasting drivers are about.


-- wli
