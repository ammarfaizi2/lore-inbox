Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSEXRaL>; Fri, 24 May 2002 13:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317198AbSEXRaK>; Fri, 24 May 2002 13:30:10 -0400
Received: from [209.184.141.163] ([209.184.141.163]:49617 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317194AbSEXRaJ>;
	Fri, 24 May 2002 13:30:09 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
From: Austin Gonyou <austin@digitalroadkill.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <423360000.1022257916@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 24 May 2002 12:30:05 -0500
Message-Id: <1022261405.9617.39.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 11:31, Martin J. Bligh wrote:
> >> I'm not sure exactly what Roy was doing, but we were taking a machine
> >> with 16Gb of RAM, and reading files into the page cache - I think we built up
> >> 8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
> >> on a P3 96 bytes.
> > 
> > The buffer heads one would make sense. I only test on realistic sized systems. 
> 
> Well, it'll still waste valuable memory there too, though you may not totally kill it.
> 
> > Once you pass 4Gb there are so many problems its not worth using x86 in the
> > long run
> 
I assume that you mean by "not worth using x86" you're referring to say,
degraded performance over other platforms? Well...if you talk
price/performance, using x86 is perfect in those terms since you can buy
more boxes and have a more fluid architecture, rather than building a
monolithic system. Monolithic systems aren't always the best. Just look
at Fermilab!

> Nah, we just haven't fixed them yet ;-)
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
