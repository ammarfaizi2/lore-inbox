Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277164AbRJHV7Z>; Mon, 8 Oct 2001 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277163AbRJHV7P>; Mon, 8 Oct 2001 17:59:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5137 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277162AbRJHV7E>; Mon, 8 Oct 2001 17:59:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zisofs doesn't compile in 2.4.10-ac7
Date: 8 Oct 2001 14:59:25 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9pt7jt$5e9$1@cesium.transmeta.com>
In-Reply-To: <25078.1002465565@ocs3.intra.ocs.com.au> <18514.1002555168@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <18514.1002555168@redhat.com>
By author:    David Woodhouse <dwmw2@infradead.org>
In newsgroup: linux.dev.kernel
> 
> While we're at it, why not move $(TOPDIR)/fs/inflate_fs/ to $(TOPDIR)/lib/zlib
> too? It's not really a filesystem-specific piece of library code, is it?
> 

It's at the best questionable if it is actually usable for anything
else.  Unfortunately the memory management issues for various clients
of zlib are rather painful.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
