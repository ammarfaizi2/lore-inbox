Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271574AbRHUGxd>; Tue, 21 Aug 2001 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271578AbRHUGxW>; Tue, 21 Aug 2001 02:53:22 -0400
Received: from rj.SGI.COM ([204.94.215.100]:4559 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271574AbRHUGxL>;
	Tue, 21 Aug 2001 02:53:11 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Richard Henderson <rth@twiddle.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /proc/ksyms change for IA64 
In-Reply-To: Your message of "Sat, 18 Aug 2001 18:27:56 MST."
             <20010818182756.A29533@twiddle.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 16:53:20 +1000
Message-ID: <31011.998376800@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001 18:27:56 -0700, 
Richard Henderson <rth@twiddle.net> wrote:
>On Thu, Aug 02, 2001 at 01:22:40PM +1000, Keith Owens wrote:
>> Using BFD is the only way I can handle all
>> the relocation types, especially in cross compile mode.
>
>What the hell?  You've got everything you need right there in 
>the obj subdirectory.  Please don't bring libbfd back to life
>in modutils.

Cross compile mode.  Nothing in modutils works unless it is running on
the machine it was compiled for.  As more modutil functions get pushed
back into kbuild time, this is getting to be a problem.  I could do all
my own code for endianess and size differences between host and target,
but why bother when bfd already does it for me?

