Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316176AbSEOHfj>; Wed, 15 May 2002 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSEOHfi>; Wed, 15 May 2002 03:35:38 -0400
Received: from ltspc67.epfl.ch ([128.178.121.34]:24205 "EHLO ltspc67.epfl.ch")
	by vger.kernel.org with ESMTP id <S316176AbSEOHfg>;
	Wed, 15 May 2002 03:35:36 -0400
Subject: Re: PROBLEM: `modprobe agpgart` locks machine badly
From: Diego SANTA CRUZ <Diego.SantaCruz@epfl.ch>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, Alex Brotman <atbrotman@earthlink.net>
In-Reply-To: <200205150647.g4F6ljY12346@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 May 2002 09:35:06 +0200
Message-Id: <1021448108.20977.68.camel@ltspc67>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-15 at 13:50, Denis Vlasenko wrote:
> On 14 May 2002 06:11, Diego SANTA CRUZ wrote:
> > I did a bit of debugging some time ago with the datasheets from intel.
> > If i remember well, the problem was that the base of the aperture is not
> > initialized by the BIOS (i.e. the APBASE register of the AGP bridge).
> >
> > This is visible in the lspci listing above, in that the Region 0 memory
> > is "<unassigned>". On the machines that I have seen with agpgart
> > working, the address of Region 0 is the address that appears in the
> > APBASE register.
> 
> Can it be set manually with setpci?

Not that I know. Besides, what would be the correct value? However, my
knowledge of hardware programming in nearly zero so...

Best,

Diego

> --
> vda
-- 
-------------------------------------------------------
Diego Santa Cruz
PhD. student
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Institute (ITS) -- formerly LTS
Swiss Federal Institute of Technology (EPFL)
EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz@epfl.ch
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------

