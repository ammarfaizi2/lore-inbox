Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbTCFHGl>; Thu, 6 Mar 2003 02:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbTCFHGl>; Thu, 6 Mar 2003 02:06:41 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:39126 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S267857AbTCFHGl>;
	Thu, 6 Mar 2003 02:06:41 -0500
Date: Thu, 6 Mar 2003 08:17:12 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: J Sloan <joe@tmsusa.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.64
Message-ID: <20030306071712.GA16713@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@digeo.com>, J Sloan <joe@tmsusa.com>,
	linux-kernel@vger.kernel.org
References: <3E66E782.5010502@tmsusa.com> <20030305223638.77c22cb7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305223638.77c22cb7.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 10:36:38PM -0800, Andrew Morton wrote:

> > Mar  5 21:17:44 jyro kernel: EIP is at __constant_c_and_count_memset+0x85/0xa0
> 
> Eh?  How come the compiler didn't inline __constant_c_and_count_memset?
> What compiler version are you using?

I see __constant_c_and_count_memset in oprofile output here too:

c013f8c0 20       0.039801    __constant_c_and_count_memset
/boot/vmlinux-2.5.64 /boot/vmlinux-2.5.64

Reading specs from
/opt/gcc-3.2.2/bin/../lib/gcc-lib/i686-pc-linux-gnu/3.2.2/specs
Configured with: ../configure --prefix=/opt/gcc-3.2.2/ --with-languages=c++
--enable-__cxa_atexit
Thread model: posix
gcc version 3.2.2


Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
