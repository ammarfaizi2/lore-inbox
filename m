Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282868AbRK0IpP>; Tue, 27 Nov 2001 03:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282867AbRK0IpF>; Tue, 27 Nov 2001 03:45:05 -0500
Received: from [195.157.147.30] ([195.157.147.30]:8722 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S282868AbRK0Iow>; Tue, 27 Nov 2001 03:44:52 -0500
Date: Tue, 27 Nov 2001 08:42:24 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Robert Love <rml@tech9.net>
Cc: Linux maillist account <l-k@mindspring.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: a nohup-like interface to cpu affinity
Message-ID: <20011127084224.C6481@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Robert Love <rml@tech9.net>,
	Linux maillist account <l-k@mindspring.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com> <E16744i-0004zQ-00@localhost> <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain> <1006472754.1336.0.camel@icbm> <E16744i-0004zQ-00@localhost> <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com> <5.0.2.1.2.20011127011901.009ebd30@pop.mindspring.com> <1006843191.838.19.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1006843191.838.19.camel@phantasy>; from rml@tech9.net on Tue, Nov 27, 2001 at 01:39:50AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 01:39:50AM -0500, Robert Love wrote:
> On Tue, 2001-11-27 at 01:32, Linux maillist account wrote:
> 
> > It's isn't quite the same..the biggest difference is races.
> 
> Then you can set the affinity on your shell before executing the
> process. :)

Surely 

#!/bin/sh

echo $1 > /proc/self/affinity
shift
exec $@

...would be just fine 'n dandy as a wrapper.


Sean
