Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUANRTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUANRSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:18:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:57998 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbUANRSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:18:22 -0500
Date: Wed, 14 Jan 2004 09:14:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: John Lash <jkl@sarvega.com>
Cc: s0095670@sms.ed.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: Catch 22
Message-Id: <20040114091456.752ad02d.rddunlap@osdl.org>
In-Reply-To: <20040114090137.5586a08c.jkl@sarvega.com>
References: <400554C3.4060600@sms.ed.ac.uk>
	<20040114090137.5586a08c.jkl@sarvega.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 09:01:37 -0600 John Lash <jkl@sarvega.com> wrote:

| On Wed, 14 Jan 2004 14:40:03 +0000
| Michael Lothian <s0095670@sms.ed.ac.uk> wrote:
| 
| > Just thaought I'd let you know about my experiences with Mandrake using
| > the 2.4 and 2.6 kernels on my new hardware which is primaraly a Asus
| > A7V600 (KT600) Motherboard and Radeon 9600XT
| > 
| > Under 2.4 my ATA hard drak is mounted under /dev/hda where as under 2.6
| > is /dev/hde so there is no wasy way to switch between them with lilo and
| > /etc/fstab needing to be changed
| > 
| 
| At least in this case, you should be able to use volume labels for the
| filesystems instead of the actual device names. Check out tune2fs -L. You then
| reference the volume label in your fstab.
| 
| With lilo, you can specify that boot disk and root disk on the command line.
| Also you can point lilo to a different config file using lilo -C. Not seamless
| but should allow you to bounce back and forth w/o editing files....

Does anyone know the reason for this (ATA ident/naming change)?

I do *not* see this and I'm also using Mandrake (v9.0, not later).

--
~Randy
MOTD:  Always include version info.
