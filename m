Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273962AbRIRXDZ>; Tue, 18 Sep 2001 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273963AbRIRXDQ>; Tue, 18 Sep 2001 19:03:16 -0400
Received: from ash.lnxi.com ([207.88.130.242]:52475 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S273962AbRIRXC7>;
	Tue, 18 Sep 2001 19:02:59 -0400
To: Ronald G Minnich <rminnich@lanl.gov>
Cc: <linux-kernel@vger.kernel.org>, <linuxbios@lanl.gov>
Subject: Re: LinuxBIOS + ASUS CUA + 2.4.5 works; with 2.4.6 locks up
In-Reply-To: <Pine.LNX.4.33.0109181655540.28482-100000@snaresland.acl.lanl.gov>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 18 Sep 2001 17:03:12 -0600
In-Reply-To: <Pine.LNX.4.33.0109181655540.28482-100000@snaresland.acl.lanl.gov>
Message-ID: <m3u1y0kspb.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald G Minnich <rminnich@lanl.gov> writes:

> We can run the memtest, but I thought that a fully booting kernel was a
> pretty good one.

It is hard to call.  The most interesting case I know of is the VIA kt133
AMD bug.  I believe it is register 0x55 bit 7 that when set causes an
athlon optimized memcpy to crash the machine, but when clear it works.

PIII optimized kernels worked fine.
 
> I'll try that anywy.

I don't expect a run of memtest86 to produce any problems but it just
feels like bad memory in the case you are describing.

Eric

