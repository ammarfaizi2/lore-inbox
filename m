Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbTAJGEm>; Fri, 10 Jan 2003 01:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTAJGEm>; Fri, 10 Jan 2003 01:04:42 -0500
Received: from d40.sstar.com ([209.205.179.40]:55549 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id <S262937AbTAJGEk>;
	Fri, 10 Jan 2003 01:04:40 -0500
Message-ID: <3E1E6492.3020300@asjohnson.com>
Date: Fri, 10 Jan 2003 00:13:38 -0600
From: Andy Johnson <andy@asjohnson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Megaraid crash (Blocked mailbox......!!) with 2.4.19-aa and 2.4.20-aa
References: <fa.i7lhfnc.1ulm3ac@ifi.uio.no>
In-Reply-To: <fa.i7lhfnc.1ulm3ac@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Kärkkäinen wrote:
> Hello!
> 
> I've seen this at least 5 times now in one month.. One of our boxes die
> when postgresql maintenance script AND backup cron jobs are ran at the =
> same
> time (by mistake - normally they are not ran at the same time)..
> 
> So it seems to be related to high disk i/o. The adapter is 
> HP NetRAID 1M with latest firmware. There is one RAID5 array with 3 dis=
> ks
> configured to it.
> 
> Usually this crash happens 1 to 2 times a week.. always when cron start=
> s to
> run the stuff at the night. The console will be flooded with "Blocked
> mailbox......!!" text (which surprisingly means that the megaraid firmw=
> are
> has stopped responding.. according to google)
> 
> This box doesn't have high disk i/o at the daytime, only at the night w=
> hen
> cron starts to do things..
> 
> When the cron jobs are not ran at the same time, the box is stable.
> 
> 
> Other box using the same kind of adapter, but RAID1 array instead, havi=
> ng
> high disk i/o all the time doesn't have any problems.. (with the same k=
> ernels).
> 
> 
> Kernels are compiled with gcc 2.95.4 (Debian 3.0).
> 
> 
> Any thoughts?

I saw this on one of our boxes running RH 6.2 with the 2.2.16 kernel
a few times in one month.  Software doesn't get old and break, usually,
so I turned the box off, reseated all the drives, and after I turned it
back on, we never had that problem again.  I think this is one of those
intermittent hardware problems.  The kind that are the most "fun" to
solve.

Good Luck,

Andy Johnson

> 
> 
> -- Pasi Kärkkäinen
>        
>                                    ^
>                                 .     .
>                                  Linux
>                               /    -    \
>                              Choice.of.the
>                            .Next.Generation.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
>  in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


