Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTDUSlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTDUSkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:40:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261876AbTDUSjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:39:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 21 Apr 2003 11:51:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b81eit$24a$1@cesium.transmeta.com>
References: <20030421193546.A10287@infradead.org> <Pine.LNX.4.44.0304211141590.9109-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304211141590.9109-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Yes, we could make dev_t's internally be always 32+32, and do the
> marshalling at stat() time. That would actually be my preferred approach, 
> and would solve some of the problems with using "dev_t" as an opaque type 
> right now (ie it would solve the "discontiguous region" issue.
> 

That would be Andries' kdev_t approach.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
