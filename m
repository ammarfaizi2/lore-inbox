Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbTGJWBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTGJV71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:59:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:260 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S269635AbTGJV54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:57:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Style question: Should one check for NULL pointers?
Date: 10 Jul 2003 15:12:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bekobi$g6l$1@cesium.transmeta.com>
References: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org> <3F0DD21B.5010408@inet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F0DD21B.5010408@inet.com>
By author:    Eli Carter <eli.carter@inet.com>
In newsgroup: linux.dev.kernel
>
> Alan Stern wrote:
> [snip]
> > Ultimately this comes down to a question of style and taste.  This 
> > particular issue is not addressed in Documentation/CodingStyle so I'm 
> > raising it here.  My personal preference is for code that means what it 
> > says; if a pointer is checked it should be because there is a genuine 
> > possibility that the pointer _is_ NULL.  I see no reason for pure 
> > paranoia, particularly if it's not commented as such.
> > 
> > Comments, anyone?
> 
> BUG_ON() perhaps?
> 

BUG_ON() is largely redundant if you would have a null pointer
reference anyway.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
