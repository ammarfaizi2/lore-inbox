Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136593AbREAHdp>; Tue, 1 May 2001 03:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136589AbREAHdf>; Tue, 1 May 2001 03:33:35 -0400
Received: from chiara.elte.hu ([157.181.150.200]:21004 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S136588AbREAHd3>;
	Tue, 1 May 2001 03:33:29 -0400
Date: Tue, 1 May 2001 09:31:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEDBEB8.449D88C3@chromium.com>
Message-ID: <Pine.LNX.4.33.0105010929510.3473-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Apr 2001, Fabio Riccardi wrote:

> Ok I fixed it, the header date timestamp is updated with every
> request.
>
> Performance doesn't seem to have suffered significantly (less than
> 1%).

yep, expected that - doing a sendmsg()+sendfile() generates the same
packet structure, the only difference being that ~100-200 bytes are copied
between kernel-space and user-space.

	Ingo

