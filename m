Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbTI3PXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTI3PXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:23:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:52689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261559AbTI3PXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:23:01 -0400
Date: Tue, 30 Sep 2003 08:14:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mrproper@ximian.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: make install problems
Message-Id: <20030930081459.01f447bf.rddunlap@osdl.org>
In-Reply-To: <1064927778.1575.0.camel@localhost.localdomain>
References: <1064927778.1575.0.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 09:16:19 -0400 Kevin Breit <mrproper@ximian.com> wrote:

| Hey,
| 	I setup a test6 kernel without module support.  I did a make install
| and got:
| 
| Kernel: arch/i386/boot/bzImage is ready
| sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6
| arch/i386/boot/bzImage System.map ""
| /lib/modules/2.6.0-test6 is not a directory.
| mkinitrd failed
| 
| How can I fix this?

We've seen this before, and I thought that we had determined that
it was a tools problem.  Is "depmod" in $PATH the depmod from
modutils or the one from module-init-tools?
I.e., what does 'depmod -V' say?

and what execs mkinitrd?  I don't find it with a quick grep.

--
~Randy
