Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUF0NPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUF0NPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 09:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUF0NPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 09:15:50 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:18924 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262109AbUF0NPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 09:15:47 -0400
Message-ID: <40DEC87A.1030902@kolivas.org>
Date: Sun, 27 Jun 2004 23:15:38 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <40DEB6CC.4030208@kolivas.org> <40DEB7B1.5010102@kolivas.org> <200406271454.32356.mbuesch@freenet.de>
In-Reply-To: <200406271454.32356.mbuesch@freenet.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Buesch wrote:
| On Sunday 27 June 2004 14:04, you wrote:
|
|>>Con Kolivas wrote:
|>>
|>>>Here is an incremental patch from 2.6.7-staircase7.4 (without any later
|>>>changes) to staircase7.6 which I hope addresses your problem of no
|>>>timeslice tasks. Can you try it please? Sorry about the previous noise.
|>>>
|>>>Con
|>>>
|>>>P.S.
|>>>Those with ck kernels I'm about to post another diff for -ck addressing
|>>>the same thing.
|>>
|>>
|>>Eeek that one I posted _was_ the one for ck kernels. This is the one for
|>>vanilla kernels with staircase7.4. Crikey I'm having a blowout here.
|
|
| No, sorry Con.
| The problem did not go away.
|
| I just verified, that it definately is no issue with -bk7. So
| I patched a clean vanilla 2.6.7 to staircase-7.6.
|
| I just double verified that the patch is applied and the correct
| kernel is loaded.

The picture fit so well with this bug I fixed I must say I'm suprised.
Well don't be sorry; you helped me indirectly track down something that
was a real bug I had missed anyway, so this update is necessary
regardless. I think for the sake of signal to noise ratio on lkml we
should take this discussion off list. Can you email me all the info you
have to date about the stalled processes and I'll take it from there?

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3sh5ZUg7+tp6mRURAs/XAJ9RRJ1jYiebZaT4YJgsVHfbpYNUqgCeOHzk
8laXqLLVG/pNntdULUnby8w=
=Rvxm
-----END PGP SIGNATURE-----
