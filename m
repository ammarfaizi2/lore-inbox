Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTBSSbP>; Wed, 19 Feb 2003 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268962AbTBSSbP>; Wed, 19 Feb 2003 13:31:15 -0500
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:63121 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S264001AbTBSSbN>; Wed, 19 Feb 2003 13:31:13 -0500
Message-ID: <3E53CFD3.A97DCD20@pp.inet.fi>
Date: Wed, 19 Feb 2003 20:41:23 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: desrt <desrt@desrt.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5: crypto core + block devices + ???
References: <1045625825.2879.8.camel@nothing.desrt.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

desrt wrote:
> I've recently been poking around the 2.5 source tree.  I've noticed that
> we now have crypto built into the stock kernel distribution (good).  The
> loopback driver doesn't appear to support using the crypto API though.
> (bad)
[snip]
> If there are no deeper motives here and the intention is to continue
> supporting encrypted filesystems via the loopback interface, is there
> anyone working on the project?  It seems a little bit slow (or
> uncertain) with respects to the 2.5 kernels.  If somebody is needed to
> write some code, I'd be willing to write a loopback transfer function to
> interact with the crypto core.  (I'd have no idea where to start for the
> generic block device crypto ramblings mentioned above...)

Loop crypto for 2.5 kernels (updated for 2.5.62) is here:

http://loop-aes.sourceforge.net/loop-AES-v1.7b.tar.bz2
http://loop-aes.sourceforge.net/updates/2003-02-19/loop-AES/Makefile.bz2
http://loop-aes.sourceforge.net/updates/2003-02-19/loop-AES/loop.c-2.5.patched.bz2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

