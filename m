Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTAFTaS>; Mon, 6 Jan 2003 14:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTAFTaS>; Mon, 6 Jan 2003 14:30:18 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:52426 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267118AbTAFTaR>;
	Mon, 6 Jan 2003 14:30:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15897.56108.201340.229554@napali.hpl.hp.com>
Date: Mon, 6 Jan 2003 11:38:20 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, bjornw@axis.com,
       davidm@hpl.hp.com, geert@linux-m68k.org, ralf@gnu.org, mkp@mkp.net,
       willy@debian.org, anton@samba.org, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp, Jeff Dike <jdike@karaya.com>
Subject: Re: Userspace Test Framework for module loader porting
In-Reply-To: <20030106022803.902F82C0E2@lists.samba.org>
References: <20030106022803.902F82C0E2@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 06 Jan 2003 13:27:02 +1100, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> BTW, the change to use shared objects for modules is going to
  Rusty> be a 2.7 thing: after 10 architectures, MIPS toolchain issues
  Rusty> made it non-trivial.  So the current stuff is what is going
  Rusty> to be there for 2.6, so no point waiting 8)

What about all the problems that Richard Henderson pointed out with
the original in-kernel module loader?  Were those solved?  My gut
feeling is that we really want shared objects for kernel modules on
ia64 (and probably alpha?).

	--david
