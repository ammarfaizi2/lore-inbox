Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315845AbSEJIli>; Fri, 10 May 2002 04:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSEJIlh>; Fri, 10 May 2002 04:41:37 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:14295
	"EHLO awak") by vger.kernel.org with ESMTP id <S315845AbSEJIlh> convert rfc822-to-8bit;
	Fri, 10 May 2002 04:41:37 -0400
Subject: Re: 2.5.15 hangs at partition check
From: Xavier Bestel <xavier.bestel@free.fr>
To: Pierre Bernhardt <mirrorgate@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>
In-Reply-To: <3CDB86C3.8050706@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 May 2002 10:40:50 +0200
Message-Id: <1021020050.25667.20.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 10/05/2002 à 10:37, Pierre Bernhardt a écrit :
> Hi,
> 
> Pierre Rousselet wrote:
> 
> > PIII / Abit BE6 HPT366, devfs.
> > 
> > 2.5.15 doesn't boot, the last lines are :
> > 
> > hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
> > hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
> > Partition check:
> >  /dev/ide/host2/bus0/target0/lun0:
> > 
> > 2.5.14 works, it gives :
> > hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
> > hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
> > Partition check:
> >  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
> >  /dev/ide/host3/bus0/target0/lun0: p1
> 
> 
> Hi,
> 
> i have the same problem on Abit BP6 with HPT366 and Kernel 2.4.18 based
> on SuSE 8.0 SMP-Kernel.
> 
> Partition check:
>   hda: hda1 hda2 hda3 hda4
>   hdc: hdc1 hdc2 hdc3 hdc4
>   hde:

Tried to disable ACPI ?


