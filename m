Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUIAAJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUIAAJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269212AbUHaWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:01:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:47782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268101AbUHaV4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:56:34 -0400
Date: Tue, 31 Aug 2004 14:53:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeremy Brand <jbrand@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MAGIC_SYSRQ on i386 unavailable?
Message-Id: <20040831145340.2d206ae6.rddunlap@osdl.org>
In-Reply-To: <f1af5b0e040831132550af6758@mail.gmail.com>
References: <f1af5b0e040831132550af6758@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 13:25:19 -0700 Jeremy Brand wrote:

| Hi all,
| 
| In the latest 2.4 and 2.6 kernels, Documentation/sysrq.txt seems to
| still mention that MAGIC SYSRQ is still available, however I can not
| find it in the configuration.  When I add CONFIG_MAGIC_SYSRQ to
| .config and run oldconfig, it vanishes.

You didn't say what architecture, and the answer may vary by arch.,
especially in 2.4.x.

In 2.4.27, you have to enable 'Kernel debugging' in the
'Kernel hacking' menu in order to be able to set MAGIC_SYSRQ.
(for i386 arch.)

In 2.6.9-rc1, you have to enable 'Kernel debugging' in the
'Kernel hacking' menu in order to be able set MAGIC_SYSRQ.

What arch. specifically?

| What is the prefered method of enabling magic sysrq on i386?  That was
| a really nice feature.  I hope it has not been removed.

Nope, not going anywhere.

--
~Randy
