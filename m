Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136107AbREDIvy>; Fri, 4 May 2001 04:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136078AbREDIvn>; Fri, 4 May 2001 04:51:43 -0400
Received: from chiara.elte.hu ([157.181.150.200]:28683 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135946AbREDIv1>;
	Fri, 4 May 2001 04:51:27 -0400
Date: Fri, 4 May 2001 10:49:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AF20CE3.63C92B3C@chromium.com>
Message-ID: <Pine.LNX.4.33.0105041028430.2178-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yet another anomaly i noticed. X15 does not appear to handle pipelined
HTTP/1.1 requests properly, it ignores the second request if two requests
arrive in the same packet.

SPECweb99 does not send pipelined requests, but a number of RL web clients
do. (Mozilla, apt-get, etc.)

	Ingo

