Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314139AbSDLTMG>; Fri, 12 Apr 2002 15:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314140AbSDLTMF>; Fri, 12 Apr 2002 15:12:05 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:28937 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S314139AbSDLTMF>;
	Fri, 12 Apr 2002 15:12:05 -0400
Subject: Re: Kernel panic 2.4.19-pre6 AND 2.4.19-pre5-ac3
From: Shawn Starr <shawn.starr@datawire.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200204121751.g3CHpBX15117@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 12 Apr 2002 15:12:04 -0400
Message-Id: <1018638725.288.3.camel@unaropia.dw>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should also be noted that my home PC (a Pentium 200Mhz) works fine
with -pre6. 

Shawn.


On Fri, 2002-04-12 at 18:54, Denis Vlasenko wrote:
> On 12 April 2002 11:33, Shawn Starr wrote:
> > The same kernel panic is observed when using 2.4.19-pre6 or
> > 2.4.19-pre5-ac3:
> 
> [snip]
> 
> > call trace:
> > [<c01b6996>][<c01ae406>][<c01b5a79>][<c013f81a>][<c01b6013>][<c01b65cf>][<c
> >01055000>[<c010506f>][<c0105000>][<c0107316>][<c0105050>]
> >
> > Code: 8b 40 20 c7 40 24 00 00 00 00 a1 a0 3e 2d c0 59 89 15 c4 cf
> 
> Run this thru ksymoops
> 
> ======== Durning boot it stopped at:
> >
> > hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.12
> > <NEVER GOT TO THIS BELOW>
> > ===========================
> > Partition check:
> >  hda: hda1 hda2 hda3 hda4
> > Floppy drive(s): fd0 is 1.44M
> > FDC 0 is a post-1991 82077
> > ===========================
> 
> I gather it used to reach "partition check" before.
> With which kernel?
> --
> vda
> 
-- 
Shawn Starr
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008

