Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275359AbTHNSqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275360AbTHNSqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:46:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7689 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S275359AbTHNSqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:46:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: C99 Initialisers
Date: 14 Aug 2003 11:45:40 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bhglck$h0q$1@cesium.transmeta.com>
References: <3F3A9FA1.8000708@pobox.com> <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
By author:    Geert Uytterhoeven <geert@linux-m68k.org>
In newsgroup: linux.dev.kernel
> 
> Aren't there any `hidden multi-function in single-function' PCI devices out
> there? E.g. cards with a serial and a parallel port?
> 

There probably are.  The easiest way to represent these is as a
"pseudo-bridge"; treat them as a bridge device with "ISA-like" serial
ports and parallel ports on the other side.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
