Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUANBeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUANBeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:34:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:48861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265667AbUANBec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:34:32 -0500
Date: Tue, 13 Jan 2004 17:31:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-Id: <20040113173113.0bed1edc.rddunlap@osdl.org>
In-Reply-To: <microsoft-free.87isjffhhz.fsf@eicq.dnsalias.org>
References: <20040113215355.GA3882@piper.madduck.net>
	<20040113143053.1c44b97d.rddunlap@osdl.org>
	<20040113223739.GA6268@piper.madduck.net>
	<20040113144141.1d695c3d.rddunlap@osdl.org>
	<20040113225047.GA6891@piper.madduck.net>
	<20040113150319.1e309dcb.rddunlap@osdl.org>
	<microsoft-free.87isjffhhz.fsf@eicq.dnsalias.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 11:26:00 +1000 Steve Youngs <sryoungs@bigpond.net.au> wrote:

| * Randy Dunlap <Randy.Dunlap> writes:
| 
|   > The message:
|   > kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
|   > is from modutils and not from module-init-tools according to my
|   > source files.
| 
| Your correct about where this message _doesn't_ come from, but not
| about where it _does_ come from...
| 
| ,----[ ./kernel/kmod.c -- lines 113 - 115 ]
| | printk(KERN_DEBUG
| |        "request_module: failed %s -- %s. error = %d\n",
| |        modprobe_path, module_name, ret);
| `----

Yes, I found that and am digging into it, but I'm close to end-of-day,
so someone else can pick it up soon...


--
~Randy
MOTD:  Always include version info.
