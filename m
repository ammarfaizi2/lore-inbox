Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261712AbSIXRQa>; Tue, 24 Sep 2002 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbSIXRQa>; Tue, 24 Sep 2002 13:16:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2319 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261712AbSIXRQ3>; Tue, 24 Sep 2002 13:16:29 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] streq()
Date: 24 Sep 2002 10:21:17 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <amq6ud$h66$1@cesium.transmeta.com>
References: <20020924045313.0FBE52C075@lists.samba.org> <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0209240731060.8824-100000@localhost.localdomain>
By author:    Ingo Molnar <mingo@elte.hu>
In newsgroup: linux.dev.kernel
> 
> we should do something about these. list_add() is hard, while we could
> introduce a separate type for list heads, there are some valid uses of
> non-head list_add(). But perhaps those could be separated out.
> 

A very, very long time ago, back in the 0.99.14 days, we actually
tried to switch to using a C++ compiler to compile the kernel, so we
could guarantee type-safe linkage.  g++ sucked back then, so the
experiment was abandoned, but I don't know if there would be interest
in trying again.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
