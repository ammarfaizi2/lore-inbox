Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRJUTaH>; Sun, 21 Oct 2001 15:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276647AbRJUT3s>; Sun, 21 Oct 2001 15:29:48 -0400
Received: from shake.vivendi.hu ([213.163.0.180]:18050 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S276646AbRJUT3o>; Sun, 21 Oct 2001 15:29:44 -0400
Date: Sun, 21 Oct 2001 21:30:11 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Message-ID: <20011021213011.A19390@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20011021093728.A17786@vega.digitel2002.hu> <E15vO29-0008ED-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <E15vO29-0008ED-00@calista.inka.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 09:13:17PM +0200, Bernd Eckenfels wrote:
> In article <20011021093728.A17786@vega.digitel2002.hu> you wrote:
> > I've never understood why people want X, StarOffice (OpenOffice) etc to be
> > moved into kernel space :)
> 
> Well, it is not a question of moving X or Office into Kernel Space. But
> current development clearly shows, that some things like Video Card Access
> need Kernel Support. IMHO the Amount of GDI related Functions in NT Kernel
> are too much, but X11 is not exactly the Windowing System you can consider
> well suited for Desktop and Game Use.

And why? I think it's perfect solution. The only problem IMHO is DGA. DGA
is not a direct competitor with DirectX because it lacks some features and
needs root privileges to use it (because it mmap()s video ram). But this
is NOT a kernel issue either: according the answer to my old letter to the
XFree mailing list it can be possible (I mean DGA access without root rights)
but it would require major modifications inside XFree so it's not planned
in the near future. What do you want to move into kernel space? IMHO the best
way is to keep as less functionalities into kernel space as possible. Other
things can be implemented in user space as well.

- Gabor
