Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSDWOB1>; Tue, 23 Apr 2002 10:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315215AbSDWOB0>; Tue, 23 Apr 2002 10:01:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12295 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S315214AbSDWOBY>;
	Tue, 23 Apr 2002 10:01:24 -0400
Date: Tue, 23 Apr 2002 11:00:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Swap related changes
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067D92@leonoid.in.ishoni.com>
Message-ID: <Pine.LNX.4.44L.0204231100030.1960-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Amol Kumar Lad wrote:

>   I am porting Linux kernel ( its by Montavista.. Hard hat 2.0 for
> embedded systems), As my board does not has any disk I want to disable
> all the swap related functionalities from VM ( I want to comment out the
> code).
>
> I think I can make some improvements in kswapd... but as swapcache and
> writepage etc are highly integrated in the VM,
> what all I can safely remove without effecting the VM functionlity.

You should be able to remove most of the functionality from
swapfile.c and swap_state.c

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

