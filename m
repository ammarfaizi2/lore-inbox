Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTJXGvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 02:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTJXGvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 02:51:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262071AbTJXGvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 02:51:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PATCH: rename legacy bus to platform bus
Date: 23 Oct 2003 23:51:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bnai56$sak$1@cesium.transmeta.com>
References: <3F97EF84.2060901@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F97EF84.2060901@hp.com>
By author:    Jamey Hicks <jamey.hicks@hp.com>
In newsgroup: linux.dev.kernel
> 
> Many of us, especially in the embedded computing world, think that 
> "legacy bus" is a misnomer.  It's not going away.  What do root PCI 
> buses connect to?  At the root of the device tree there is a bus.  This 
> patch changes the name from legacy bus to platform bus.  I'm hoping this 
> change can be made even this late in the development cycle.  It is a 
> pretty small patch but I think that naming is very important.
> 

>From a PCI terminology perspective, this is misleading.

The root PCI bus connects to a HOST bus.

The LEGACY bus connects to the subtractive decoding device.

In a PC system, LEGACY busses are basically ISA and LPC.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
