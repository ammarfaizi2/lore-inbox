Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287579AbRLaRyd>; Mon, 31 Dec 2001 12:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287584AbRLaRyX>; Mon, 31 Dec 2001 12:54:23 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46094 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287577AbRLaRyK>;
	Mon, 31 Dec 2001 12:54:10 -0500
Date: Mon, 31 Dec 2001 18:53:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: andihartmann@freenet.de, riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20011231185350.1ca25281.skraw@ithnet.com>
In-Reply-To: <3C309CDC.DEA9960A@megsinet.net>
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com>
	<3C2F04F6.7030700@athlon.maya.org>
	<3C309CDC.DEA9960A@megsinet.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001 11:14:04 -0600
"M.H.VanLeeuwen" <vanl@megsinet.net> wrote:

> [...]
> vmscan patch:
> 
> a. instead of calling swap_out as soon as max_mapped is reached, continue to
try>    to free pages.  this reduces the number of times we hit
try_to_free_pages() and>    swap_out().

I experimented with this some time ago, but found out it hit performance and
(to my own surprise) did not do any good at all. Have you tried this
stand-alone/on top of the rest to view its results?

Regards,
Stephan

