Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289063AbSANVSZ>; Mon, 14 Jan 2002 16:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSANVKh>; Mon, 14 Jan 2002 16:10:37 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:27024 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289070AbSANVJk>; Mon, 14 Jan 2002 16:09:40 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Banai Zoltan <bazooka@enclavenet.hu>
Subject: Re: slowdown with new scheduler.
Date: Mon, 14 Jan 2002 22:08:23 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020114202903.8BA9176330@public.kitware.com>
In-Reply-To: <20020114202903.8BA9176330@public.kitware.com>
Cc: Heinz Diehl <hd@cavy.de>, Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114211010Z289070-13997+4807@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14. January 2002 20:42, you wrote:
> On Mon, Jan 14, 2002 at 08:29:25PM +0100, Heinz Diehl wrote:
> > On Mon Jan 14 2002, Heinz Diehl wrote:
> >
> > > 2.4.18-pre3             real    7m55.243s
> > >                         user    6m34.080s
> > >                         sys     0m27.610s
> > > 
> > > 2.4.18-pre+H7                   real    7m35.962s
> > >                         user    6m34.270s
> > >                         sys     0m27.700s
> > > 
> > > 2.4.18-pre3-ac2         real    7m39.203s
> > >                         user    6m34.110s
> > >                         sys     0m28.740s
> > > 
> >
> > 2.4.18-pre3+H7+preempt-rml  real    6m58.983s
> >                           user    6m34.500s
> >                           sys     0m27.820s
> >
> That sounds very good! But what about the VM code?
> Is the VM in 2.4.18-pre3+H7 as good as in 2.4.18-pre2aa2?

Of course _NOT_.
This is like apples and oranges...

You _must_ compare
2.4.18-pre3+H7+ -aa vm-22 from 2.4.18-pre2aa2
with
2.4.18-pre3+H7+ -rmap

After that you should apply preempt+locl-break or LL to both.

Have a look into Re: [2.4.17/18pre] VM and swap - it's really unusable

Greetings,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
