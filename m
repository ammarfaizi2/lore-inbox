Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281436AbRKTWYq>; Tue, 20 Nov 2001 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281439AbRKTWYg>; Tue, 20 Nov 2001 17:24:36 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:45070 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281436AbRKTWYa>; Tue, 20 Nov 2001 17:24:30 -0500
Message-ID: <3BFAD7EA.136A65A0@zip.com.au>
Date: Tue, 20 Nov 2001 14:23:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: riel@conectiva.com.br, dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <Pine.LNX.4.33L.0111202004220.4079-100000@imladris.surriel.com>,
		<037701c1720a$159ee9a0$1a01a8c0@allyourbase>
		<Pine.LNX.4.33L.0111202004220.4079-100000@imladris.surriel.com> <20011120.141129.57454002.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Tue, 20 Nov 2001 20:05:05 -0200 (BRST)
> 
>    Consider this a VM bug, mmap() really should be more efficient.
> 
> read() is always going to be faster until mmap() can
> use large page mappings for the user.  This is why
> mmap() is slower.
> 
> Even if the whole thing is cached in memory, read() will
> always be faster.

Could you please explain further?  What's more expensive
than the copy?
