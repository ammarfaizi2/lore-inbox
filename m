Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUANAEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266280AbUANAEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:04:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:38562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266278AbUANAEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:04:46 -0500
Date: Tue, 13 Jan 2004 16:01:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "David Rees" <drees@greenhydrant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-Id: <20040113160131.79520358.rddunlap@osdl.org>
In-Reply-To: <3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com>
References: <20040113215355.GA3882@piper.madduck.net>
	<20040113143053.1c44b97d.rddunlap@osdl.org>
	<20040113223739.GA6268@piper.madduck.net>
	<20040113144141.1d695c3d.rddunlap@osdl.org>
	<20040113225047.GA6891@piper.madduck.net>
	<20040113150319.1e309dcb.rddunlap@osdl.org>
	<3156.208.48.139.163.1074037125.squirrel@www.greenhydrant.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 15:38:45 -0800 (PST) "David Rees" <drees@greenhydrant.com> wrote:

| On Tue, January 13, 2004 at 3:03 pm, Randy.Dunlap wrote:
| >
| > OK, maybe someone else has an answer then.
| >
| > The message:
| > kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
| > is from modutils and not from module-init-tools according to my
| > source files.
| 
| I'm getting similar messages from dmesg after upgrading to 2.6.1, too:
| 
| request_module: failed /sbin/modprobe -- n. error = 256
| 
| [drees@summit drees]$ /sbin/modprobe -V
| module-init-tools version 3.0-pre5
| [drees@summit drees]$
| 
| Running on Fedora Core 1 compiled with gcc 3.3.2.  Didn't see these with
| 2.6.0.

Yes, I see a couple of similar messages:

request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
request_module: failed /sbin/modprobe -- fb0. error = 256

...?

--
~Randy
MOTD:  Always include version info.
