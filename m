Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUE0I6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUE0I6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 04:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUE0I6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 04:58:23 -0400
Received: from mail02.hansenet.de ([213.191.73.62]:46994 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261793AbUE0I6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 04:58:21 -0400
Message-ID: <40B5AD70.7000903@hanse.net>
Date: Thu, 27 May 2004 10:57:20 +0200
From: =?UTF-8?B?TWFsdGUgU2NocsO2ZGVy?= <Malte.Schroeder@hanse.net>
Reply-To: MalteSch@gmx.de
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: MalteSch@gmx.de, Andi Kleen <ak@muc.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
References: <1ZqbC-5Gl-13@gated-at.bofh.it>	 <m3r7t9d3li.fsf@averell.firstfloor.org>	 <20040525122659.395783f4@highlander.Home.LAN>	 <20040525123636.GA13817@colin2.muc.de> <1085520021.1393.4168.camel@duergar>	 <20040526122658.2121389e@highlander.Home.LAN> <1085615502.4543.26.camel@duergar>
In-Reply-To: <1085615502.4543.26.camel@duergar>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| For completeness could you test the OSS emu10k driver (which supports
| PCM, while the ALSA driver does not) and see if you experience better
| overall performance?  Like less CPU utilization etc... I'm very
| interested in finding out where the bottlenecks are.  The emu10k1
| driver
| isn't perfect and neither are xine or mplayer so I'd like figure out
| what  exactly  is going on here.  I'll of course do the same.  It's just
| kind of hard to judge for me seeing as my system is now 4 years old.

I dont think it would make a difference sice cpu-time used by system is
really low since switching off mmap. But my overall experience with the
emu10k1 alsa-driver since it hit version 1.0 is quite good (before there
where some issues or should I say "annoyances" with the mixer). But if
you really want this I can rebuild my kernel and swith all that
oss-stuff back on ;)

Greets
- --
- ---------------------------------------
Malte Schröder
MalteSch@gmx.de
ICQ# 68121508
- ---------------------------------------

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAta1w4q3E2oMjYtURAt+AAJ0XTwmxsRsAgASfpfeWqs+DlQqdKwCfQ2Hy
dYqPGy93HVcqjYJTFsKyayE=
=nxDc
-----END PGP SIGNATURE-----
