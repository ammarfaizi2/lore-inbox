Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUBEQqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUBEQqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:46:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:46266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265269AbUBEQqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:46:08 -0500
Date: Thu, 5 Feb 2004 08:39:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Nicholas Berry" <nikberry@med.umich.edu>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: change kernel name
Message-Id: <20040205083949.7738937d.rddunlap@osdl.org>
In-Reply-To: <s021eb13.042@med-gwia-02a.med.umich.edu>
References: <s021eb13.042@med-gwia-02a.med.umich.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Feb 2004 07:04:26 -0500 "Nicholas Berry" <nikberry@med.umich.edu> wrote:

| Note the words 'after the compilation'.

I think that the other person who answered 'no' was close enough.

BTW, did you say what processor architecture and what kernel
image file format?  If it's a zipped kernel image, changing text
in it is a bit tougher, I guess.  If it's not zipped, almost
anything could change that string (just not make it larger).

--
~Randy

| >>> "Richard B. Johnson" <root@chaos.analogic.com> 02/04/04 07:38AM
| >>>
| On Tue, 3 Feb 2004, Gaspar Bakos wrote:
| 
| > Hello,
| >
| > I have the following question:
| > If I compile the kernel (2.4.*) and boot it in, then the
| kernel-release,
| > as shown by 'uname -r' will be the string that was in the
| EXTRAVERSION
| > string from the kernel Makefile.
| > Is there any way to change this 'identity' of the kernel after the
| > compilation?
| > Such as
| > changekernelname bzImage "newname"
| 
| Put anything you want in the structure, system_utsname, in your copy
| of
| linux-nn-nn/init/version.c.
| 
| Cheers,
| Dick Johnson
| Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
|             Note 96.31% of all statistics are fiction.
