Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272774AbRJBMIH>; Tue, 2 Oct 2001 08:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRJBMH5>; Tue, 2 Oct 2001 08:07:57 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:17031 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S272774AbRJBMHs> convert rfc822-to-8bit; Tue, 2 Oct 2001 08:07:48 -0400
Date: Tue, 2 Oct 2001 14:07:56 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Stephane Dudzinski <stephane@antefacto.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx error
In-Reply-To: <1002023119.29779.34.camel@steph>
Message-ID: <Pine.LNX.4.31.0110021405070.2265-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2 Oct 2001, Stephane Dudzinski wrote:

> Definitly hardware related, one of your hdds is beginning to die. Backup
> is the next step·
>
> On Tue, 2001-10-02 at 12:44, Roland Kuhn wrote:
> >  I/O error: dev 08:61, sector 10180768
> > SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> > Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
> >  I/O error: dev 08:61, sector 10180520
> > SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> > Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
> >  I/O error: dev 08:61, sector 10180272
> > SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> > Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
> >  I/O error: dev 08:61, sector 10180024
> > SCSI disk error : host 1 channel 0 id 2 lun 0 return code = 8000000
> > Info fld=0x400001f4 (nonstd), Current sd08:61: sense key None
> >  I/O error: dev 08:61, sector 10179776
>
I forgot to tell you that this also happened to a brand-new Cheetah after
5 hours of bonnie...

Generally, there has to be at least some moderate load to be going on on
the bus. This time it was a tape backup of ID 0 running in parallel with
the scp on ID 2.

Ciao,
					Roland

+-----------------------------------------------------+
|    Tel.:    089/32649332        0561/873744         |
|    in       Radeberger Weg 8    Am Fasanenhof 16    |
|             85748 Garching      34125 Kassel        |
+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+
|             May the Source be with you!             |
+-----------------------------------------------------+

