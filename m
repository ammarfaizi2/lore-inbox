Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135629AbRDXNzU>; Tue, 24 Apr 2001 09:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135624AbRDXNxj>; Tue, 24 Apr 2001 09:53:39 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:10514 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S135616AbRDXNxE>; Tue, 24 Apr 2001 09:53:04 -0400
Date: Tue, 24 Apr 2001 15:52:55 +0200 (CEST)
From: Tomas Telensky <ttel5535@ss1000.ms.mff.cuni.cz>
Reply-To: ttel5535@artax.karlin.mff.cuni.cz
To: Alexander Viro <viro@math.psu.edu>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.GSO.4.21.0104240926290.6992-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104241550510.12074-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Alexander Viro wrote:

> 
> 
> On Tue, 24 Apr 2001, Tomas Telensky wrote:
> 
> > of linux distributions the standard daemons (httpd, sendmail) are run as
> > root! Having multi-user system or not! Why? For only listening to a port
> > <1024? Is there any elegant solution?
> 
> Sendmail is old. Consider it as a remnant of times when network was
> more... friendly. Security considerations were mostly ignored - and
> not only by sendmail. It used to be choke-full of holes. They were
> essentially debugged out of it in late 90s. It seems to be more or
> less OK these days, but it's full of old cruft. And splitting the
> thing into reasonable parts and leaving them with minaml privileges
> they need is large and painful work.

Thanks for the comment. And why not just let it listen to 25 and then
being run as uid=nobody, gid=mail?
  Tomas

> 
> There are alternatives (e.g. exim, or two unmentionable ones) that are
> cleaner. Besides, there are some, erm, half-promises that next major
> release of sendmail may be a big cleanup. Hell knows what will come out
> of that.
> 

