Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288610AbSADMIO>; Fri, 4 Jan 2002 07:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSADMIF>; Fri, 4 Jan 2002 07:08:05 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41333 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S288610AbSADMHz>; Fri, 4 Jan 2002 07:07:55 -0500
Date: Fri, 4 Jan 2002 12:09:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Harald Holzer <harald.holzer@eunet.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <Pine.LNX.4.33L.0201031129410.24031-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0201041206290.16016-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Rik van Riel wrote:
> On Thu, 3 Jan 2002, Alan Cox wrote:
> > A lot of it is the page structs (64bytes per page - which really
> > should be nearer the 32 some rival Unix OS's achieve on x86)
> 
> The 2.4 kernel has the page struct at 52 bytes in size,
> William Lee Irwin and I have brought this down to 36.

Please restate those numbers, Rik: I share Alan's belief that the
current standard 2.4 kernel has page struct at 64 bytes in size.

Hugh

