Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbTFXDbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 23:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265650AbTFXDbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 23:31:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44294 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265649AbTFXDbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 23:31:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel & BIOS return differing head/sector geometries
Date: 23 Jun 2003 20:45:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bd8hgj$cas$1@cesium.transmeta.com>
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030624013908.B1133@pclin040.win.tue.nl>
By author:    Andries Brouwer <aebr@win.tue.nl>
In newsgroup: linux.dev.kernel
> 
> Linux does not use the BIOS, and does not use CHS either, so geometry is
> totally and completely irrelevant to Linux.
> 

Actually, unless you have it "linear" or "lba32", LILO *does* use
CHS.  Unfortunately.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
