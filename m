Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285386AbRLNO6A>; Fri, 14 Dec 2001 09:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285388AbRLNO5v>; Fri, 14 Dec 2001 09:57:51 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:44360 "EHLO
	c0mailgw11.prontomail.com") by vger.kernel.org with ESMTP
	id <S285386AbRLNO5e>; Fri, 14 Dec 2001 09:57:34 -0500
Message-ID: <3C1A11AF.610B9B02@starband.net>
Date: Fri, 14 Dec 2001 09:50:23 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kristian Peters <kristian.peters@korseby.net>
CC: Wakko Warner <wakko@animx.eu.org>, Jeff <piercejhsd009@earthlink.net>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net> <3C19DEAF.4080703@korseby.net> <20011214064202.A24719@animx.eu.org> <3C1A0DF6.5030401@korseby.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That just means it is not a standard compliant CDRW drive.
I've asked Joerg Schilling about this and that's what he said.
I get the same thing.

Linux sg driver version: 3.1.20
Using libscg version 'schily-0.5'
scsibus0:
        0,0,0     0) *
        0,1,0     1) *
        0,2,0     2) 'IOMEGA  ' 'ZIP 100         ' 'J.03' Removable Disk
        0,3,0     3) 'MATSHITA' 'CD-ROM CR-8008  ' '8.0e' Removable CD-ROM
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus1:
        1,0,0   100) '        ' 'SMART100X/2400  ' '1.44' Removable CD-ROM
        1,1,0   101) 'PLEXTOR ' 'CD-R   PX-W1210A' '1.09' Removable CD-ROM
cdrecord: Warning: controller returns wrong size for CD capabilities page.
        1,2,0   102) 'MATSHITA' 'CD-ROM CR-581-M ' '1.05' Removable CD-ROM
        1,3,0   103) 'HP      ' 'CD-Writer+ 7500 ' '1.0a' Removable CD-ROM
        1,4,0   104) 'SONY    ' 'CD-ROM CDU77E-Q ' '1.3a' Removable CD-ROM
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *


Kristian Peters wrote:

> Wakko Warner wrote:
>
> > I get this same thing with a scsi cdrom at work.  I have 2 of the exact same
> > drives.  a Teac cd-535s v1.0a  the first one I get that message, the second
> > works.  However, the first one won't pull the tray back in via software.
>
> Is the first drive connected to /dev/hdb ? Does eject work on /dev/scd0 or
> /dev/hdb ?
>
> *Kristian
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

