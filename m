Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbRATX2A>; Sat, 20 Jan 2001 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131439AbRATX1u>; Sat, 20 Jan 2001 18:27:50 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:56735 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130138AbRATX1e>; Sat, 20 Jan 2001 18:27:34 -0500
Date: Sat, 20 Jan 2001 23:27:35 +0000 (GMT)
From: James Sutherland <mandrake@cam.ac.uk>
To: Lincoln Dale <ltd@cisco.com>
cc: Kai Henningsen <kaih@khms.westfalen.de>, <linux-kernel@vger.kernel.org>,
        dean gaudet <dean-list-linux-kernel@arctic.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <4.3.2.7.2.20010121100103.02820730@171.69.63.141>
Message-ID: <Pine.LNX.4.30.0101202325210.8238-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2001, Lincoln Dale wrote:

> hi,
>
> At 04:56 PM 20/01/2001 +0200, Kai Henningsen wrote:
> >dean-list-linux-kernel@arctic.org (dean gaudet)  wrote on 18.01.01 in
> ><Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>:
> > > i'm pretty sure the actual use of pipelining is pretty disappointing.
> > > the work i did in apache preceded the widespread use of HTTP/1.1 and we
> >
> >What widespread use of HTTP/1.1?
>
> this is probably digressing significantly from linux-kernel related issues,
> but i owuld say that HTTP/1.1 usage is more widespread than your probably
> think.
>
> from the statistics of a beta site running a commercial transparent caching
> software:
>          <cache># show statistics http requests
>                                        Statistics - Requests
>                                         Total       %
>                                  ---------------------------
>          ...
>                     HTTP 0.9 Requests:      41907     0.0
>                     HTTP 1.0 Requests:   37563201    24.1
>                     HTTP 1.1 Requests:  118282092    75.9
>                 HTTP Unknown Requests:          1     0.0

IIRC, the discrepancy is because some browsers (IE, not sure about
Netscape) default to speaking HTTP/1.0 to a proxy if they are configured
to use one - a chicken and egg situation, AFAICS: proxies are assumed to
be HTTP 1.0 only, so browsers only send HTTP 1.0 requests - so people look
at the logs and think 90% of their users are HTTP/1.0 only anyway, so
there's no point in supporting 1.1 yet...

Also something to do with HTTP 1.1 being much harder to support properly
in proxies due to the new cache control features etc.??

James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
