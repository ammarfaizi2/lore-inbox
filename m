Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290218AbSBFHik>; Wed, 6 Feb 2002 02:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSBFHif>; Wed, 6 Feb 2002 02:38:35 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:17557 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290218AbSBFHhT>; Wed, 6 Feb 2002 02:37:19 -0500
Message-ID: <XFMail.20020206083631.R.Oehler@GDAmbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <002f01c1ae96$143af4a0$0501a8c0@Stev.org>
Date: Wed, 06 Feb 2002 08:36:31 +0100 (MET)
From: Ralf Oehler <R.Oehler@GDAmbH.com>
To: James Stevenson <mistral@stev.org>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@kernel.org>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Scsi <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Feb-2002 James Stevenson wrote:
|   > Hi, List
|   >
|   > I think, I found a very simple solution for this annoying BUG().
|   >
|   > Since at least kernel 2.4.16 there is a BUG() in pci.h,
|   > that crashes the kernel on any attempt to read a SCSI-Sector
|   > from an erased MO-Medium and on any attempt to read
|   > a sector from a SCSI-disk, which returns "Read-Error".
|   >
|   > There seems to be a thinko in the corresponding code, which
|   > does not take into account the case where a SCSI-READ
|   > does not return any data because of a "sense code: read error"
|   > or a "sense code: blank sector".
|   >
|    
|    would this also happen with the ide-scsi driver then
|    and would this explain why i see panic's on when reading
|    cd's ?
|    
 I don't know (yet), but it`s well possible.



 --------------------------------------------------------------------------
|  Ralf Oehler                          
|                                       
|  GDA - Gesellschaft fuer Digitale                              _/
|        Archivierungstechnik mbH & CoKG                        _/
|  Ein Unternehmen der Bechtle AG               #/_/_/_/ _/_/_/_/ _/_/_/_/
|                                              _/    _/ _/    _/       _/
|  E-Mail:      R.Oehler@GDAmbH.com           _/    _/ _/    _/ _/    _/
|  Tel.:        +49 6182-9271-23             _/_/_/_/ _/_/_/#/ _/_/_/#/
|  Fax.:        +49 6182-25035                    _/
|  Mail:        GDA, Bensbruchstraﬂe 11,   _/_/_/_/
|               D-63533 Mainhausen      
|  HTTP:        www.GDAmbH.com         
 --------------------------------------------------------------------------

time is a funny concept
