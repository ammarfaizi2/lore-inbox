Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbUCHRII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUCHRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:08:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:59264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262301AbUCHRIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:08:05 -0500
Date: Mon, 8 Mar 2004 09:06:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-Id: <20040308090640.2d557f9e.rddunlap@osdl.org>
In-Reply-To: <404C8A35.3020308@helsinki.fi>
References: <40408852.8040608@helsinki.fi>
	<20040228104105.5a699d32.rddunlap@osdl.org>
	<40419A1C.5070103@helsinki.fi>
	<20040301101706.3a606d35.rddunlap@osdl.org>
	<404C8A35.3020308@helsinki.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2004 16:59:01 +0200 Kliment Yanev wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| 
| 
| Randy.Dunlap wrote:
| 
| | All of the kernel interface functions to PCMCIA Card Services have
| | changed in 2.6 so quite a bit of code will have to be changed here.
| | You can ask Nokia for a 2.6 update since it is now released, or
| | you can ask for help from the linux-wlan (or wlan-ng) project people,
| | or you can compare a 2.4 PCMCIA kernel driver to a 2.6 PCMCIA kernel
| | driver to see what changes are required.
| |
| 
| I compared the orinoco_cs drivers in 2.4 and 2.6 and I updated the nokia
| driver source. However now I get "-1 unknown symbol in module" when I
| try to insmod the module... where should I start troubleshooting?

Set the console loglevel to 9 so that you can see all of the
kernel messages and then try to reload the module.  Some explanatory
error message should appear to indicate the problem area.

--
~Randy
