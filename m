Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288703AbSANCzQ>; Sun, 13 Jan 2002 21:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288697AbSANCzH>; Sun, 13 Jan 2002 21:55:07 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:56330 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288703AbSANCyw>;
	Sun, 13 Jan 2002 21:54:52 -0500
Date: Mon, 14 Jan 2002 00:54:32 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <028b01c19c90$87300760$02c8a8c0@kroptech.com>
Message-ID: <Pine.LNX.4.33L.0201140052030.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Adam Kropelin wrote:

> From: "Alan Cox" <alan@redhat.com>
>
> > People keep bugging me about the -ac tree stuff so this is whats in my
> > current internal diff with the ll patch and the ide changes excluded.

> For the sake of completeness I ran my large inbound FTP transfer test
> (details in the "Writeout in recent kernels..." thread) on this
> release. Performance and observed writeout behavior was essentially
> the same as for 2.4.17, both stock and with -rmap11a. Transfer time
> was 6:56 and writeout was uneven. 2.4.13-ac7 is still the winner by a
> significant margin.

I'm looking into this bug, I just finished the first large
dbench test set on 2.4.17-rmap11b with 512 MB RAM, tomorrow
I'll run them with 128 and 32 MB of RAM.

Luckily you have already shown the other recent kernels to
have the same performance, so I only have to do half a day
of testing. I'll try to track down this bug and get it fixed.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

