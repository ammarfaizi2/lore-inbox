Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUHMR0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUHMR0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMR0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:26:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:42369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266240AbUHMRZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:25:43 -0400
Date: Fri, 13 Aug 2004 10:00:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: bunk@fs.tum.de, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-Id: <20040813100040.3fce00db.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408131312390.20634@scrub.home>
References: <20040813101717.GS13377@fs.tum.de>
	<Pine.LNX.4.58.0408131231480.20635@scrub.home>
	<1092394019.12729.441.camel@uganda>
	<Pine.LNX.4.58.0408131253000.20634@scrub.home>
	<20040813110137.GY13377@fs.tum.de>
	<Pine.LNX.4.58.0408131312390.20634@scrub.home>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 14:11:28 +0200 (CEST) Roman Zippel wrote:

| Hi,
| 
| On Fri, 13 Aug 2004, Adrian Bunk wrote:
| 
| > But the similar case of USB_STORAGE selecting SCSI is an example where 
| > select is a big user-visible improvement over depends.
| 
| comment "USB storage requires SCSI"
| 	depends on SCSI=n
| 
| That's also user visible and doesn't confuse the user later, why he can't 
| deselect SCSI.

User-visible in xconfig (and gconfig?).  Not in menuconfig, right?
Maybe menuconfig's Help could also display dependency info...

| Abusing select is really the wrong answer. What is needed is an improved 
| user interface, which allows to search through the kconfig information or 
| even can match hardware information to a driver and aids the user in 
| selecting the required dependencies.

Nice idea.  So are there places where SELECT is the right thing to do,
i.e., it's required?  (examples, please)

| Keeping the kconfig database clean and making kernel configuration easier 
| are really two separate problems and we shouldn't sacrifice the former for 
| the latter.


--
~Randy
