Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265391AbUBJCHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 21:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUBJCHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 21:07:32 -0500
Received: from hera.kernel.org ([63.209.29.2]:22447 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265391AbUBJCHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 21:07:30 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Does anyone still care about BSD ptys?
Date: Tue, 10 Feb 2004 02:07:22 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c09ecq$h11$1@terminus.zytor.com>
References: <c07c67$vrs$1@terminus.zytor.com> <c07i5r$ctq$1@news.cistron.nl> <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk> <c09ccl$qkl$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076378842 17442 63.209.29.3 (10 Feb 2004 02:07:22 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 10 Feb 2004 02:07:22 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <c09ccl$qkl$1@gatekeeper.tmr.com>
By author:    davidsen@tmr.com (bill davidsen)
In newsgroup: linux.dev.kernel
>
> In article <20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk>,
>  <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> 
> | So what's the problem with calling mount(2)?
> 
> Other than making an optional part of the kernel required... Not
> impossible but something to consider.
> 

With my changes the devpts filesystem will be pretty much an integral
part of the pty system (since the whole idea is to use the devpts
filesystem to keep track of the tty structures) so that's not an
issue.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
