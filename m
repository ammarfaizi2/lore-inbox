Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbSLNBVG>; Fri, 13 Dec 2002 20:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbSLNBVG>; Fri, 13 Dec 2002 20:21:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267484AbSLNBVF>; Fri, 13 Dec 2002 20:21:05 -0500
Date: Fri, 13 Dec 2002 17:29:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Braam <braam@clusterfs.com>
cc: linux-kernel@vger.kernel.org, <intermezzo-devel@lists.sourceforge.net>,
       <rddunlap@osdl.org>
Subject: Re: [PATCH] intermezzo update
In-Reply-To: <20021211192105.GA1649@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212131727380.8797-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied (after fixups), but I also moved the intermezzo header files into
intermezzo's own directory instead of leaving them in <linux/*.h>. I don't
see why anybody else should care about intermezzo-specific stuff.

Btw, the thing still doesn't actually compile, since there is no io_deamon
file checked in, even though the makefile says it wants one.

		Linus

