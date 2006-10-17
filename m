Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWJQSQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWJQSQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWJQSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:16:48 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:34212 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751022AbWJQSQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:16:47 -0400
Date: Tue, 17 Oct 2006 20:12:45 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: schilling@fokus.fraunhofer.de, ismail@pardus.org.tr
Cc: Me@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <45351d1d.zzAZVd00Wr6s9fu8%Joerg.Schilling@fokus.fraunhofer.de>
References: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de>
 <200610172041.42873.ismail@pardus.org.tr>
In-Reply-To: <200610172041.42873.ismail@pardus.org.tr>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez <ismail@pardus.org.tr> wrote:

> 17 Eki 2006 Sal 17:45 tarihinde, Joerg Schilling Å?unlarÄ± yazmÄ±Å?tÄ±: 
> > Hi,
> >
> > while working on better ISO-9660 support for the Solaris Kernel,
> > I recently enhanced mkisofs to support the Rock Ridge Standard version 1.12
> > from 1994.
> >
> > The difference bewteen version 1.12 and 1.10 (this is what previous
> > mkisofs versions did implement) is that the "PX" field is now 8 Byte
> > bigger than before (44 instead of 36 bytes).
>
> Is there a test iso file somewhere? I think the attached *untested* patch will 
> fix it.

Well, this is why I did offer a preliminary version of thelatest mkisofs 
sources.....


But note: your patch does not fix the original implementation bug and it is most
unlikely that the hack will do the right things in all cases.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
