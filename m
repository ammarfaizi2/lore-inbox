Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbSAHEYj>; Mon, 7 Jan 2002 23:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287647AbSAHEY3>; Mon, 7 Jan 2002 23:24:29 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:12934 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S287645AbSAHEYL>; Mon, 7 Jan 2002 23:24:11 -0500
Date: Tue, 8 Jan 2002 15:23:49 +1100
From: CaT <cat@zip.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: netfilter oops (Was: Re: Linux 2.4.18-pre2)
Message-ID: <20020108042348.GB1982@zip.com.au>
In-Reply-To: <Pine.LNX.4.21.0201072130170.18722-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201072130170.18722-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.25i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 09:38:17PM -0200, Marcelo Tosatti wrote:
> Here goes pre2.
> 
> 
> pre2: 
*snip*

As I was off the net for 2 weeks I wanted to wait for the next pre
release before reporting this bug (incase I missed something and someone
solved it anyways). Anyhow I'm assuming it still applies to pre2 as
there has been no mention of netfilter changes in the changelog, so...

With 18-pre1, 17-rc2 and 17-preX (can't remember now. It's been a week
or so :/) I can get the kernel to consistantly crash after a few minutes
by compiling it with ipchains compatability and using masqueraded net
connections. If I connect to the getway in quetion without hitting the
masq rules I'm fine. I can also use the net from the gateway, but if I
try to use the net from a box behind it and that box gets masqueraded I
get a kernel lockup and an oops after a minute or so of use. Unfortunately
the oops doesn't actually get recorded anywhere and all I can remember
from it is that it was dieing in 'Swapper task' (or something similar).

I did a bit more experimentation and removed all the netfilter changes
done since 2.4.16 and I no longer got oopses so one of the changes after
2.4.16 broke things.

Unfortunately, I am no longer near said gateway. I -can- try and
duplicate this as soon as I get a version of linux compiling on a debian
woody system.

If you have any questions/requests/whatnots then please yell. If I
succeed in duplicateing this and get a recorded oops I'll send that in
also.

Thanks.

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
