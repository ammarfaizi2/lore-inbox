Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRE2IEu>; Tue, 29 May 2001 04:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbRE2IEk>; Tue, 29 May 2001 04:04:40 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:60932 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261274AbRE2IEZ>; Tue, 29 May 2001 04:04:25 -0400
Date: Tue, 29 May 2001 19:35:40 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Kurt Roeckx <Q@ping.be>, Russell King <rmk@arm.linux.org.uk>,
        Vadim Lebedev <vlebedev@aplio.fr>, linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529193540.A7029@metastasis.f00f.org>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529001256.F9203@flint.arm.linux.org.uk> <20010529013030.A3381@ping.be> <20010529014635.A3499@ping.be> <20010529023222.C6061@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010529023222.C6061@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Tue, May 29, 2001 at 02:32:23AM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 02:32:23AM +0200, Jamie Lokier wrote:

    By the way, the context stored on the stack is entirely a user
    space context, however it does include some information from the
    kernel that may be useful to user space, such as a page fault
    address.

I actually (ab)used this for userspace paging with mprotect and
friends.... nasty hack :)



  --cw
