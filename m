Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287313AbSACOfD>; Thu, 3 Jan 2002 09:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287310AbSACOex>; Thu, 3 Jan 2002 09:34:53 -0500
Received: from ns.ithnet.com ([217.64.64.10]:40716 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287303AbSACOeu>;
	Thu, 3 Jan 2002 09:34:50 -0500
Date: Thu, 3 Jan 2002 15:33:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: harald.holzer@eunet.at, linux-kernel@vger.kernel.org, wookie@osdl.org,
        velco@fadata.bg
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-Id: <20020103153355.612bd269.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0201031106590.24031-100000@imladris.surriel.com>
In-Reply-To: <1010015450.15492.19.camel@hh2.hhhome.at>
	<Pine.LNX.4.33L.0201031106590.24031-100000@imladris.surriel.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 11:28:45 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

> Another item to look into is removing the page cache hash table
> and replacing it by a radix tree or hash trie, in the hopes of
> improving scalability while at the same time saving some space.

Ah, didn't we see such a patch lately in LKML? If I remember correct I saw some
comparison charts too and some people testing it were happy with it. Just
searched through the list: 24. dec :-) by Momchil Velikov Can someone with big
mem have a look at the saving? How about 18-pre?

Regards,
Stephan
