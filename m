Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTEIRYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbTEIRYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:24:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25350 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263314AbTEIRYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:24:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hammer: MAP_32BIT
Date: 9 May 2003 10:36:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9gouv$3rf$1@cesium.transmeta.com>
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030509092026.GA11012@averell>
By author:    Andi Kleen <ak@muc.de>
In newsgroup: linux.dev.kernel
> 
> MAP_32BIT currently limits to the first 2GB only. That's needed because
> most programs use it to allocate modules for the small code model and that
> only supports 2GB (poster child for that is the X server) But for your 
> application 4GB would be better. But adding another MAP_32BIT_4GB or so
> would be quite ugly. I considered making the address where mmap starts searching
> (TASK_UNMAPPED_BASE) settable using a prctl.
> 

MAP_31BIT would have been a better name...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
