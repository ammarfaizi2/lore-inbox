Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSLITcf>; Mon, 9 Dec 2002 14:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSLITcf>; Mon, 9 Dec 2002 14:32:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266038AbSLITce>; Mon, 9 Dec 2002 14:32:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Proposed ACPI Licensing change
Date: 9 Dec 2002 11:39:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <at2ric$fj9$1@cesium.transmeta.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com> <20021207002405.GR2544@fs.tum.de> <astkea$6ej$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <astkea$6ej$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
> 
> In fact, I don't think I'd even merge a patch where the submitter tried
> to limit dual-license code to a simgle license (it might happen with
> some non-maintained stuff where the original source of the dual license
> is gone, but if somebody tried to send me an ACPI patch that said "this
> is GPL only", then I just wouldn't take it). 
> 
> So yes, dual-license code can become GPL-only, but not in _my_ tree. 
> 

This is good.  I'd like to keep klibc under a BSD/GPL license because
some people (e.g. Al Viro) have issued concerns about making a
nondynamic user-space library GPL or LGPL, and I pretty much agree
with their concerns.  The current klibc tarball isn't completely
"untainted", since it contains "fixed"/modified kernel headers in a
few places, but I'm hoping to migrate those changes back into the
kernel headers proper once the merge is done.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
