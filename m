Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUAPL2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 06:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAPL2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 06:28:43 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:6849 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265374AbUAPL2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 06:28:41 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Raw I/O Problems with inb()
Date: Fri, 16 Jan 2004 12:27:47 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.01.16.11.27.43.359172@smurf.noris.de>
References: <20040115215243.39fcb0fd.aftli@optonline.net>
NNTP-Posting-Host: pd951dc4d.dip.t-dialin.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1074252469 25555 217.81.220.77 (16 Jan 2004 11:27:49 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 16 Jan 2004 11:27:49 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Brett Gmoser wrote:

> Thanks in advance for any insight you all may be able to give me

Reading port registers directly doesn't make sense. No USB keyboards, no
remote use, ... you need to drop your DOS programming mentaility. Fast.

You can use a PTY approach like script(1), or you can write a small kernel
module like evbug (see the kernel source, drivers/input/evbug.c) which
monitors everything the user is doing.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
There are two distinct sorts of what we call bashfulness; this, the
awkwardness of a booby, which a few steps into the world will convert into the
pertness of a cox comb; that, a consciousness, which the most delicate
feelings produce, and the most extensive knowledge cannot always remove.
					-- Mackenzie

