Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290496AbSAYB7e>; Thu, 24 Jan 2002 20:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290495AbSAYB7Y>; Thu, 24 Jan 2002 20:59:24 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10500 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290494AbSAYB7V>;
	Thu, 24 Jan 2002 20:59:21 -0500
Date: Thu, 24 Jan 2002 21:51:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <knobo@linpro.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile error -rmap12a and 2.4.18-pre7
In-Reply-To: <ujpadv3tj87.fsf@false.linpro.no>
Message-ID: <Pine.LNX.4.33L.0201242147030.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2002 knobo@linpro.no wrote:

> I applied first rmap12a ant then 2.4.18-pre7
>
> then I removed line 502 (i think) "nr_pages--" from
> linux/mm/vmscan.c. (thanx to mjc)

Yes, this line is added by the -pre7 patch.

The reason I haven't upgraded -rmap to -pre7 yet is that
I used to pull the new kernel patches from Ted T'so's
2.4 bitkeeper tree, but he hasn't updated his tree yet.

I think I'll have to re-do his changes to bk's import
script so I can import incremental kernel patches with
the changelog messages in the bk tree ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

