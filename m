Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJHQ1I>; Tue, 8 Oct 2002 12:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJHQ1I>; Tue, 8 Oct 2002 12:27:08 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:61241 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S261406AbSJHQ1D>;
	Tue, 8 Oct 2002 12:27:03 -0400
From: <Hell.Surfers@cwctv.net>
To: david.lang@digitalinsight.com, simon@baydel.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 17:32:25 +0100
Subject: RE:Re: The end of embedded Linux?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034094745201"
Message-ID: <03be754301608a2DTVMAIL5@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034094745201
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Nobody said if you GPL it they would have to put it in the kernel...

Cheers, Dean.

On 	Tue, 8 Oct 2002 08:52:49 -0700 (PDT) 	David Lang <david.lang@digitalinsight.com> wrote:

--1034094745201
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Tue, 8 Oct 2002 17:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbSJHQGB>; Tue, 8 Oct 2002 12:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbSJHQF4>; Tue, 8 Oct 2002 12:05:56 -0400
Received: from [209.195.52.120] ([209.195.52.120]:60900 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S261307AbSJHQFy>; Tue, 8 Oct 2002 12:05:54 -0400
Received: from no.name.available by warden2.diginsite.com
          via smtpd (for vger.kernel.org [209.116.70.75]) with SMTP; Tue, 8 Oct 2002 09:09:55 -0700
Received: from atlexc01.digitalinsight.com ([10.2.43.7])
          by atlims01.digitalinsight.com (Post.Office MTA v3.5.3
          release 223 ID# 0-0U10L2S100V35) with ESMTP id com;
          Tue, 8 Oct 2002 12:16:03 -0400
Received: by atlexc01.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <4LX430XF>; Tue, 8 Oct 2002 12:05:30 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id 4LXG671L; Tue, 8 Oct 2002 09:00:39 -0700
From: David Lang <david.lang@digitalinsight.com>
To: simon@baydel.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 08:52:49 -0700 (PDT)
Subject: Re: The end of embedded Linux?
In-Reply-To: <3DA2BD70.14919.2C6951@localhost>
Message-ID: <Pine.LNX.4.44.0210080850270.3110-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

note that you are allowed to distribute a binary-only module as long as
you don't use the GPL-only kernel symbols. Linus has stated that he
doesn't view use of the header files as enough to make a module a
dirivitive work (others disagree, but there are a number of binary modules
out there)

check the archives for the various flame wars over this issue.

David Lang

On Tue, 8 Oct 2002 simon@baydel.com wrote:

> Date: Tue, 8 Oct 2002 11:11:44 +0100
> From: simon@baydel.com
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: The end of embedded Linux?
>
> On 7 Oct 2002, at 21:22, Alan Cox wrote:
>
> > On Mon, 2002-10-07 at 18:15, simon@baydel.com wrote:
> > > a serial port and an interupt controller. What I was trying to explain
> > > was that I would not mind making my code available for these
> > > kernel changes. Although I don't understand why anyone would
> > > want it. Apart from API changes, why do this ? The kernel is not
> > > easily or frequently changed on this type of system. It would bloat
> > > the kernel and I would expect to have to address problems of this
> > > nature myself.  However I would not like to make code available for
> > > the more specialised hardware.
> >
> > That depends how specialized the hardware actually is. I think I've see
> > six different non free implementations of 68360 sync serial code around
> > all proprietary for example.
> >
>
> The UART and Interrupt controllers in question are built into a gate
> array. I can't see how any external or parts from other vendors
> would be compatible. To get the board to boot Linux I have to
> modify the kernel and lilo. I understand that under the GPL rules I
> would have to make this code available. I am willing to do this but I
> don't see the point.
>
> There is also more specialized hardware for which I have written
> modules. Although there appears to be some unwritten rule about
> releasing objects, I believe that the GPL rules state that these
> modules must conform to the GPL also, as they contain header
> files. I cannot see how any module can not contain Linux headers
> or headers derived from Linux headers if it is to be loaded on a
> Linux kernel.
>
> These modules again drive gate array hardware for which nobody
> else will ever have a compatible. Although I would dearly love to
> use Linux as the platform for my project I feel I cannot release this
> code under the GPL.
>
> This is my dilemma and I am sure it is shared by others. For this
> reason I cannot see how anything but an embedded PC with
> applications or a perhaps a very simple hardware device could be
> considered as an opportunity for  embedded Linux.
>
> I have based these thoughts on my experiences so far. If you feel I
> have drawn an incorrect conclusion I would be grateful for your
> input.
>
>
> Many Thanks
>
> Simon.
>
>
>
> > Also my original comments were much more aimed at the core stuff. People
> > who made existing and especially core stuff smaller could send the stuff
> > out. Several of us want to compile a CONFIG_TINY option, and suprisingly
> > enough small is good on high end boxes. My L1 cache is 8 times faster
> > than my L2 cache is 7 times faster than my memory. Or to put it another
> > way, going to main memory costs me maybe 100 instructions.
> >
> > My Athlon thinks small is good too!
> >
>
>
> __________________________
>
> Simon Haynes - Baydel
> Phone : 44 (0) 1372 378811
> Email : simon@baydel.com
> __________________________
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034094745201--


