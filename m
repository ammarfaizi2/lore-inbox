Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285532AbRLNVts>; Fri, 14 Dec 2001 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285540AbRLNVti>; Fri, 14 Dec 2001 16:49:38 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:2571
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S285532AbRLNVtb>; Fri, 14 Dec 2001 16:49:31 -0500
Date: Fri, 14 Dec 2001 17:01:05 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: war <war@starband.net>
Cc: Kristian Peters <kristian.peters@korseby.net>,
        Jeff <piercejhsd009@earthlink.net>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
Message-ID: <20011214170105.B25469@animx.eu.org>
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net> <3C19DEAF.4080703@korseby.net> <20011214064202.A24719@animx.eu.org> <3C1A0DF6.5030401@korseby.net> <3C1A11AF.610B9B02@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C1A11AF.610B9B02@starband.net>; from war on Fri, Dec 14, 2001 at 09:50:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That just means it is not a standard compliant CDRW drive.
> I've asked Joerg Schilling about this and that's what he said.
> I get the same thing.
> 
> Linux sg driver version: 3.1.20
> Using libscg version 'schily-0.5'
> scsibus0:
>         0,0,0     0) *
>         0,1,0     1) *
>         0,2,0     2) 'IOMEGA  ' 'ZIP 100         ' 'J.03' Removable Disk
>         0,3,0     3) 'MATSHITA' 'CD-ROM CR-8008  ' '8.0e' Removable CD-ROM
>         0,4,0     4) *
>         0,5,0     5) *
>         0,6,0     6) *
>         0,7,0     7) *
> scsibus1:
>         1,0,0   100) '        ' 'SMART100X/2400  ' '1.44' Removable CD-ROM
>         1,1,0   101) 'PLEXTOR ' 'CD-R   PX-W1210A' '1.09' Removable CD-ROM
> cdrecord: Warning: controller returns wrong size for CD capabilities page.
>         1,2,0   102) 'MATSHITA' 'CD-ROM CR-581-M ' '1.05' Removable CD-ROM
>         1,3,0   103) 'HP      ' 'CD-Writer+ 7500 ' '1.0a' Removable CD-ROM
>         1,4,0   104) 'SONY    ' 'CD-ROM CDU77E-Q ' '1.3a' Removable CD-ROM
>         1,5,0   105) *
>         1,6,0   106) *
>         1,7,0   107) *

Ok, but why would having 2 identical cdroms be different?  they both have
the same firmware, yet cdrecord -scanbus shows one of them with the wrong
size thing.  There's 2 scsi controllers, but if I swap them, the wrong size
stays with the drive, not the controller.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
