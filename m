Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRFXTsL>; Sun, 24 Jun 2001 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264444AbRFXTsG>; Sun, 24 Jun 2001 15:48:06 -0400
Received: from CM-46-30.chello.cl ([24.152.46.30]:26240 "EHLO
	CM-46-30.chello.cl") by vger.kernel.org with ESMTP
	id <S264447AbRFXTrh>; Sun, 24 Jun 2001 15:47:37 -0400
Date: Sun, 24 Jun 2001 15:44:34 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
To: safemode <safemode@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi detecting CDR as "CD-ROM" in 2.2.19
In-Reply-To: <20010624192618Z264415-17721+5482@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0106241543230.637-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try cdrecord --scanbus and folow the directions on CD-Writing HOWTO.

On Sun, 24 Jun 2001, safemode wrote:

> I'm using the ide patch "ide.2.2.19.05042001" for 2.2.19.   In 2.4.5 this cdr 
> wsa detected as a cdr.  here it's detected as:
>   Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> 
> Cdrecord says this.
> cdrecord: Invalid argument. Cannot get mmap for 4198400 Bytes on /dev/zero.
> TOC Type: 1 = CD-ROM
> 
> How do i make it be detected as a cdrw or at least cdr?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

 ---
 Fabian Arias Mu~oz                    |               Debian GNU/Linux Sid
 Facultad de Cs. Economicas y          |      	Kernel 2.4.5ac17 - ReiserFS
 Administrativas.                      |                   "aka" dewback en
 Universidad de Concepcion   -  Chile  |               #linuxhelp IRC.CHILE

