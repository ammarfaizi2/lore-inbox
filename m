Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290520AbSAYDft>; Thu, 24 Jan 2002 22:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290528AbSAYDfk>; Thu, 24 Jan 2002 22:35:40 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:11013 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290520AbSAYDf2>;
	Thu, 24 Jan 2002 22:35:28 -0500
Date: Fri, 25 Jan 2002 01:35:08 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <rwhron@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18pre4aa1
In-Reply-To: <20020124222357.C901@earthlink.net>
Message-ID: <Pine.LNX.4.33L.0201250132450.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 rwhron@earthlink.net wrote:

> > It would be interesting to see the dbench dots from both
> > -aa and -rmap ;)
>
> All the dots are at:
> http://home.earthlink.net/~rwhron/kernel/dots/

I think we have an explanation here.

With dbench 192 on -aa the first processes exit around
halfway through the dbench test and around the end only
few processes are left.

With rmap the write trottling is a bit smoother, but
this results in all processes running to about 70% through
the test and many more processes running at the last part
of the test, exiting simultaneously.

Considering the possible bad consequences for real
workloads, I'm not sure I want to make the system more
unfair just to better accomodate dbench ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

