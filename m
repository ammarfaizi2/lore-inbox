Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSJPHRx>; Wed, 16 Oct 2002 03:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSJPHRx>; Wed, 16 Oct 2002 03:17:53 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:14601 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S264938AbSJPHRw>; Wed, 16 Oct 2002 03:17:52 -0400
Date: Wed, 16 Oct 2002 00:23:45 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
Message-ID: <20021016072345.GE7844@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021015165947.50642.qmail@web13801.mail.yahoo.com> <aoi6bb$309$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoi6bb$309$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 03:54:35PM -0700, H. Peter Anvin wrote:
> Followup to:  <20021015165947.50642.qmail@web13801.mail.yahoo.com>
> By author:    Padraig O Mathuna <padraigo@yahoo.com>
> In newsgroup: linux.dev.kernel
> > 
> > I'm developing some drivers for the AU1000 under
> > Mountain Vista's 2.4.17 sherman release. The AU1000 is
> > a MIPS based SOC with a 36 bit internal address bus
> > and a 32 bit MIPS cpu.  According to the documentation
> > the MIPS' TLB is able to map 32 bit virtual addresses
> > to 36 bit physical addresses, however I cannot figure
> > out how to get Linux to set this up.  I've looked at
> > ioremap which only takes unsigned long (32bits) as an
> > argument to assign a virtual address.  Is there
> > another way?
> > 
> 
> Oh no, the x86 madness is spreading!!!!
> 
> (It's depressing this happening on a MIPS system, which has been 64
> bits since who-knows-when...)
> 
> *Vomit*
> 
> 	-hpa

Can't say exactly when but my MIPS RISC Architecture manual
for the R2000/R3000 shows it to be a _strictly_ 32 bit
architecture in 1988 and i distinctly remember the working
with the newest R400x in 1993 which was still 32bit.  I
know MIPS went to 64bit sometime not too long after that
(mid 90's?) but by then Alpha and Sparc had beaten them to
the punch.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
