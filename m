Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbUAPRlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265577AbUAPRlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:41:45 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:56797 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265576AbUAPRln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:41:43 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Raw I/O Problems with inb()
Date: Fri, 16 Jan 2004 18:41:25 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.01.16.17.41.22.932043@smurf.noris.de>
References: <20040115215243.39fcb0fd.aftli@optonline.net> <pan.2004.01.16.11.27.43.359172@smurf.noris.de> <6.0.1.1.0.20040116094624.00acea40@optonline.net>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1074274889 18775 192.109.102.39 (16 Jan 2004 17:41:29 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 16 Jan 2004 17:41:29 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Brett Gmoser wrote:

> The question is not one of "how" to accomplish all of this, it is how to 
> get inb(0x64) to state that it is indeed mouse movement, and not keyboard 
> data, on an AMD Athlon XP system with PS/2 mouse.

Well, as I said, I would solve the "how" problem with a kernel module
which monitors mouse movement or keyboard events. This happens to be a
whole lot more reliable, and it will also eat no CPU time when nothing's
happening.

Plus, it will work on any mouse or keyboard. People actually _use_ USB
critters these days, you know ...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Sign my PETITION.
		-- Zippy the Pinhead

