Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271852AbTG2Pih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271854AbTG2Pih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:38:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:18316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271852AbTG2Pig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:38:36 -0400
Date: Tue, 29 Jul 2003 08:35:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jakub@redhat.com
Cc: szepe@pinerecords.com, jamagallon@able.es, kwall@kurtwerks.com,
       lcapitulino@prefeitura.sp.gov.br, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-Id: <20030729083507.3dd20485.rddunlap@osdl.org>
In-Reply-To: <1059479661.3118.5.camel@dhcp22.swansea.linux.org.uk>
References: <1059396053.442.2.camel@lorien>
	<20030728225017.GJ32673@louise.pinerecords.com>
	<20030729002221.GD263@kurtwerks.com>
	<20030729045512.GM32673@louise.pinerecords.com>
	<20030729092857.GA28348@werewolf.able.es>
	<20030729093521.GA1286@louise.pinerecords.com>
	<20030729094820.GC28348@werewolf.able.es>
	<20030729095858.GB1286@louise.pinerecords.com>
	<20030729101126.GC29124@werewolf.able.es>
	<20030729102007.GC1286@louise.pinerecords.com>
	<1059479661.3118.5.camel@dhcp22.swansea.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2003 12:57:52 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

| On Maw, 2003-07-29 at 11:20, Tomas Szepe wrote:
| > > What is the difference between backporting a patch from 3.3.1-pre to 3.3,
| > > and using 3.3.1-pre directly ? Ah, that you get less bug corrected.
| > 
| > Large.  3.3 is a development series.  It DOES introduce new stuff.
| > 
| > In production environments you definitely want to stick with 3.2.3
| > or (better yet) 2.95.3.
| 
| 3.2 is probably the best, but lots of people are using gcc 3.3 to build
| kernels and so far all the things we've hit have been the stricter
| parser throwing up on technically invalid C in the kernel source/

I really hate to get this back to the original problem, but is
the reported warning a gcc 3.3.x problem?  I don't see the assembly
problem here.

| arch/i386/kernel/reboot.c: In function `machine_restart':
| arch/i386/kernel/reboot.c:261: warning: use of memory input without
| lvalue in asm operand 0 is deprecated

--
~Randy
