Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268879AbRG0Q1i>; Fri, 27 Jul 2001 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268883AbRG0Q12>; Fri, 27 Jul 2001 12:27:28 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:7377 "EHLO mx01-a.netapp.com")
	by vger.kernel.org with ESMTP id <S268879AbRG0Q1X>;
	Fri, 27 Jul 2001 12:27:23 -0400
Date: Fri, 27 Jul 2001 09:25:23 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: Hans Reiser <reiser@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B61893D.A532BD6F@namesys.com>
Message-ID: <Pine.GSO.4.10.10107270919430.8579-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing





> Alan Cox wrote:
> > 
> > > Don't use RedHat with ReiserFS, they screw things up so many ways.....
> > > For instance, they compile it with the wrong options set, their boot scripts are wrong, they just
> > > shovel software onto the CD.
> > 
> > Sorry Hans you can rant all you like but you know you are wrong on most
> > of that. RH did weeks of stress testing on multiple systems up to 8Gb 8 way
> > and didn't ship until we stopped seeing corruption problems with the mm/fs
> > code.

Sorry Alan, but even though I am sure Redhat did lots of stress testing,
Redhat 7.1 was not a particularly solid release. I got oopses in the
eepro100 driver even though lots of other people use it, and the netapp
simulator which works just fine on 2.2.16 does not work on it. When I ran
strace on the simulator while it was zeroing some files it turned out that
sys_write was failing with ENOMEM (on a machine with 1GB of RAM that was 
not doing anything else).

