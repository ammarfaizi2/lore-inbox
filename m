Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSCYByT>; Sun, 24 Mar 2002 20:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311532AbSCYByJ>; Sun, 24 Mar 2002 20:54:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:16389 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311025AbSCYByC>; Sun, 24 Mar 2002 20:54:02 -0500
Message-ID: <3C9E82DA.99D53C94@zip.com.au>
Date: Sun, 24 Mar 2002 17:52:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Anyone else seen VM related oops on 2.4.18?
In-Reply-To: <20020325005633.GA1121@Ado.student.utwente.nl> <Pine.LNX.4.44L.0203242200080.18660-100000@imladris.surriel.com> <20020325011139.GA1165@Ado.student.utwente.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan Opmeer wrote:
> 
> On Sun, Mar 24, 2002 at 10:01:09PM -0300, Rik van Riel wrote:
> > On Mon, 25 Mar 2002, Arjan Opmeer wrote:
> >
> > > Are there other people that are suffering from a VM related oops on
> > > kernel 2.4.18?
> > >
> > > ... I am just trying to find out whether the kernel or the driver
> > > upgrade is causing this problem.
> >
> > Well, can you reproduce the problem without the NVidia driver ?
> 
> I am waiting... :)
> 

Please ensure that the kernel was built with `verbose BUG reporting',
under the kernel hacking menu.

And when it happens again, make sure that you take note
of the line number at which it's hitting the BUG().  It'll
be `Kernel BUG at page_alloc.c:NNN'.

-
