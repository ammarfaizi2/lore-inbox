Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317050AbSEWXhG>; Thu, 23 May 2002 19:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317051AbSEWXhF>; Thu, 23 May 2002 19:37:05 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:15013 "EHLO
	goose.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S317050AbSEWXhE>; Thu, 23 May 2002 19:37:04 -0400
Subject: Re: PROBLEM: `modprobe agpgart` locks machine badly
From: Alex Brotman <atbrotman@earthlink.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1021448108.20977.68.camel@ltspc67>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 May 2002 19:32:37 -0400
Message-Id: <1022196760.1785.0.camel@mycomp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well lets assume i wanted to use 'e0000000'(based on win32) as my value
for region 0 on PCI device 00:00.0 .. How would i use setpci to
manipulate those settings?  The man page wasn't much help.  Thanks.

On Wed, 2002-05-15 at 03:35, Diego SANTA CRUZ wrote:
> On Wed, 2002-05-15 at 13:50, Denis Vlasenko wrote:
> > On 14 May 2002 06:11, Diego SANTA CRUZ wrote:
> > > I did a bit of debugging some time ago with the datasheets from intel.
> > > If i remember well, the problem was that the base of the aperture is not
> > > initialized by the BIOS (i.e. the APBASE register of the AGP bridge).
> > >
> > > This is visible in the lspci listing above, in that the Region 0 memory
> > > is "<unassigned>". On the machines that I have seen with agpgart
> > > working, the address of Region 0 is the address that appears in the
> > > APBASE register.
> > 
> > Can it be set manually with setpci?
> 
> Not that I know. Besides, what would be the correct value? However, my
> knowledge of hardware programming in nearly zero so...
> 
> Best,
> 
> Diego
> 
> > --
> > vda
> -- 
> -------------------------------------------------------
> Diego Santa Cruz
> PhD. student
> Publications available at http://ltswww.epfl.ch/~dsanta
> Signal Processing Institute (ITS) -- formerly LTS
> Swiss Federal Institute of Technology (EPFL)
> EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
> E-mail:     Diego.SantaCruz@epfl.ch
> Phone:      +41 - 21 - 693 26 57
> Fax:        +41 - 21 - 693 76 00
> -------------------------------------------------------
> 


