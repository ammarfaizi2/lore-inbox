Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSHaBBq>; Fri, 30 Aug 2002 21:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSHaBBp>; Fri, 30 Aug 2002 21:01:45 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:33015 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315454AbSHaBBo>; Fri, 30 Aug 2002 21:01:44 -0400
Date: Fri, 30 Aug 2002 18:01:45 -0700
From: Chris Wright <chris@wirex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
Message-ID: <20020830180145.B11165@figure1.int.wirex.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux FSdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Dave McCracken <dmccr@us.ibm.com>
References: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com> <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Aug 31, 2002 at 01:51:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> 
> Needs fsuid too, and space for the security LSM modules to attach
> private information. SELinux needs a few more credentials than base
> kernels!

Yes, I agree.  LSM is just using opaque blobs, so it's simple enough to
add.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
