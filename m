Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTKUFtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 00:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTKUFtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 00:49:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9479 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264301AbTKUFtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 00:49:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Announce: ndiswrapper
Date: 20 Nov 2003 21:48:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bpk908$jcd$1@cesium.transmeta.com>
References: <20031120172454.GB14608@bougret.hpl.hp.com> <Pine.LNX.3.96.1031120174823.11021B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.96.1031120174823.11021B-100000@gatekeeper.tmr.com>
By author:    Bill Davidsen <davidsen@tmr.com>
In newsgroup: linux.dev.kernel
> 
> I'm curious if the NDIS stuff could be run in ring 1 or 2, being an old
> MULTICS guy. Not for political reasons, just good tech.
> 

Unfortunately the segmentation and paging were so poorly integrated in
i386 that rings 1-2 are pretty much totally useless.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
