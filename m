Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWJQTk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWJQTk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWJQTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:40:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:51087 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751230AbWJQTk4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:40:56 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Date: Tue, 17 Oct 2006 21:28:20 +0300
User-Agent: KMail/1.9.5
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
References: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de> <200610172041.42873.ismail@pardus.org.tr> <45351d1d.zzAZVd00Wr6s9fu8%Joerg.Schilling@fokus.fraunhofer.de>
In-Reply-To: <45351d1d.zzAZVd00Wr6s9fu8%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610172128.20653.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

17 Eki 2006 Sal 21:12 tarihinde, Joerg Schilling şunları yazmıştı: 
> Ismail Donmez <ismail@pardus.org.tr> wrote:
> > 17 Eki 2006 Sal 17:45 tarihinde, Joerg Schilling Å?unlarÄ± yazmÄ±Å?tÄ±:
> > > Hi,
> > >
> > > while working on better ISO-9660 support for the Solaris Kernel,
> > > I recently enhanced mkisofs to support the Rock Ridge Standard version
> > > 1.12 from 1994.
> > >
> > > The difference bewteen version 1.12 and 1.10 (this is what previous
> > > mkisofs versions did implement) is that the "PX" field is now 8 Byte
> > > bigger than before (44 instead of 36 bytes).
> >
> > Is there a test iso file somewhere? I think the attached *untested* patch
> > will fix it.
>
> Well, this is why I did offer a preliminary version of thelatest mkisofs
> sources.....

Well a simple mkisofs some_file > test.iso and mounting that on a loop device 
worked fine.


> But note: your patch does not fix the original implementation bug and it is
> most unlikely that the hack will do the right things in all cases.

Well I don't know whats the original implementation bug and rock.c seems to be 
pretty much old with no active maintainer.

Regards,
ismail
