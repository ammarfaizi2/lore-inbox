Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTL1V7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTL1V7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 16:59:55 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:37564 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S262116AbTL1V7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 16:59:53 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: SUCCESS Re: 2.6.0-test11-mm1
Date: Sun, 28 Dec 2003 22:59:25 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.12.28.21.59.24.427087@smurf.noris.de>
References: <20031217014350.028460b2.akpm@osdl.org> <pan.2003.12.26.18.22.17.611727@smurf.noris.de> <Pine.LNX.4.58.0312261114040.14874@home.osdl.org>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1072648764 27243 192.109.102.39 (28 Dec 2003 21:59:24 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 28 Dec 2003 21:59:24 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus Torvalds wrote:
> Matthias Urlichs:
>> [ -mm1 success story ]

>> If somebody _really_ needs to know, I can try to binary-search for the
>> patch that's responsible, but it'd take a month to find out anything
>> conclusive 
> 
> It would be good to even get a "good hint", even if it won't be
> conclusive.

I'll try to narrow it down somewhat. Unfortunately, the nature of binary
search is so that even if I manage to declare half of the patches as
irrelevant, that doesn't help much.

[ time passes while I forgot to send this message ]

Oh happiness. :-/  At least part of the bug (galeon misplaces text) still
exists, as it turns out, though it's a lot harder to trigger with
2.6.0-mm1. Since the galeon thing was usually the first Special Effect to
show up, this may well be two different bugs -- and I'm not ruling out an
application problem.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
It isn't easy being a Friday kind of person in a Monday kind of world.

