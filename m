Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271413AbTHMPVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275062AbTHMPVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:21:47 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:23441 "EHLO server")
	by vger.kernel.org with ESMTP id S271413AbTHMPVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:21:44 -0400
Message-ID: <076901c361ae$9a105030$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, mason@suse.com, green@namesys.com
References: <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Date: Wed, 13 Aug 2003 08:21:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: <akpm@osdl.org>; <andrea@suse.de>; <alan@lxorguk.ukuu.org.uk>;
<linux-kernel@vger.kernel.org>; <mason@suse.com>; <green@namesys.com>
Sent: Wednesday, August 13, 2003 7:53 AM
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)


>
>
> On Wed, 13 Aug 2003, Stephan von Krawczynski wrote:
>
> > On Fri, 8 Aug 2003 12:33:28 -0300 (BRT)
> > Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> >
> > > That will provide further information yes. We can then know if the
problem
> > > is reiserfs specific or not, which is VERY useful.
> > >
> > > Again, thanks for your efforts helping us track down the problem.
> >
> > Status update:
> >
> > uptime:
> >  12:45pm  up 2 days 19:39,  18 users,  load average: 2.02, 2.05, 2.06
> >
> > Running SMP. So far no crash happened under ext3.
> > Still I see the tar-verification errors. None on the first day, 2 on the
second
> > and 2 today so far.
> > I see a growing possibility that the formerly crashes are directly
linked to a
> > reiserfs problem, maybe broken SMP-locking.
> > If it survives until sunday I will revert all ext3 back to reiserfs to
be sure
> > it still crashes, then ideas for patches will be welcome :-)
>
> Great you tracked it down. Your previous traces almost always involved
> reiserfs calls, which is another indicator that reiserfs is probably the
> problem here.
>
> Chris, Oleg, it might be nice if you guys could look at previous oops
> reports by Stephan.
>
Marcelo,
    Could this be related to the issues I was having. Since rc1 I have not
had any problems, and I have all the iptables stuff running again. My
machine is smp and is using ext3.


