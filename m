Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281519AbRKUAUB>; Tue, 20 Nov 2001 19:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281512AbRKUATw>; Tue, 20 Nov 2001 19:19:52 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:44050 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281525AbRKUATf>;
	Tue, 20 Nov 2001 19:19:35 -0500
Date: Tue, 20 Nov 2001 22:19:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <akpm@zip.com.au>, <dmaas@dcine.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <20011120.154004.123980549.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0111202218360.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, David S. Miller wrote:
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Tue, 20 Nov 2001 21:35:40 -0200 (BRST)
>
>    On Tue, 20 Nov 2001, David S. Miller wrote:
>    > TLB misses add to the cost, and this overhead is more than
>    > "noise".

> The Apache folks were keeping it mapped across requests,
> so even if it was "primed" (ie. pre-faulted), a read() into
> a static buffer was still significantly faster.

Interesting.  I wonder how read() and mmap() compare when the
data is in highmem pages and we're facing a kmap()/kunmap()
for read() ...

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

