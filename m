Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOEs6>; Tue, 14 Nov 2000 23:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKOEss>; Tue, 14 Nov 2000 23:48:48 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:2496 "EHLO nabiki.mountain.net")
	by vger.kernel.org with ESMTP id <S129091AbQKOEsj>;
	Tue, 14 Nov 2000 23:48:39 -0500
Message-ID: <3A120C6E.ADFE4C24@mountain.net>
Date: Tue, 14 Nov 2000 23:09:18 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Hard lockups solved
In-Reply-To: <3A1073B4.CDCA21DF@mountain.net> <200011140114.RAA14493@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Mon, 13 Nov 2000 18:05:24 -0500
>    From: Tom Leete <tleete@mountain.net>
> 
>    Your net/ipv4/tcp.c patch from the NE2000 thread cured them even
>    before I found the hardware fault. Has that patch gone to the
>    queue? I recommend it.
> 
> The bugs I was "fixing" there were due to problems in wait queue
> exclusivity nesting.  We instead fixed wait queue exclusivity nesting
> so it actually worked in test11-pre3, can you see if by itself that
> kernel does not show your problems too?
> 
> Thanks.
> 
> Later,
> David S. Miller
> davem@redhat.com

Done. Yes, it's fixed in vanilla test11-pre3, to go by
limited testing. ftp, 15 Meg in 4 files -- no deathlike
sleep, md5sums agree. That load would have certainly
triggered the problem before. On to pre5.

Thanks again,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
