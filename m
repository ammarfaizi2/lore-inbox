Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADEvm>; Wed, 3 Jan 2001 23:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADEvc>; Wed, 3 Jan 2001 23:51:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:9226 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129324AbRADEv0>; Wed, 3 Jan 2001 23:51:26 -0500
Date: Wed, 3 Jan 2001 20:51:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: bdflush synchronous IO on prerelease-diff 
In-Reply-To: <Pine.LNX.4.21.0101040016580.839-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101032047590.8789-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mind checking out the current prerelease-diff? It fixes this, and cleans
up some remaining things (now that we don't task-switch into bdflush for
all our cleanup, 'nrefill' should really be much lower to get smoother
behavior).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
