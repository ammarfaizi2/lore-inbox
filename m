Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSGNPyD>; Sun, 14 Jul 2002 11:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGNPyC>; Sun, 14 Jul 2002 11:54:02 -0400
Received: from codepoet.org ([166.70.99.138]:58855 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316900AbSGNPyA>;
	Sun, 14 Jul 2002 11:54:00 -0400
Date: Sun, 14 Jul 2002 09:56:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714155651.GA5440@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Joerg Schilling <schilling@fokus.gmd.de>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <200207141420.g6EEKtX4019135@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207141420.g6EEKtX4019135@burner.fokus.gmd.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jul 14, 2002 at 04:20:55PM +0200, Joerg Schilling wrote:
> 
> >From andersen@codepoet.org Sat Jul 13 07:49:29 2002
> 
> >On Fri Jul 12, 2002 at 10:17:21PM +0100, Alan Cox wrote:
> >> CD burning is a side issue to stability and reliability. 
> >> 
> >> In terms of supporting old hardware most of that is irrelevant to cd
> >> recording anyway, so why do you care ? What you actually need is a
> >> generic interface for cd packet sending.
> 
> >A generic interface for cd packet sending?  Sounds useful.  So
> >useful someone thought of it years ago, and called it the
> >CDROM_SEND_PACKET ioctl.  Its been in the kernel since Aug 1999.
> >What'll those crazy Linux CD-ROM people think of next?
> 
> We don't need just another unrelated interface but a generic
> transort. CDROM_SEND_PACKET is not a generic interface, it is limited
> to ATAPI CD-ROM's.

Wrong.  It is a _generic CD-ROM packet interface.  Thanks for not even
spending the two seconds it would take reading the kernel source code
to discover this.

$ grep -l CDC_GENERIC_PACKET drivers/scsi/sr.c drivers/ide/ide-cd.c 
drivers/scsi/sr.c
drivers/ide/ide-cd.c

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
