Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312145AbSCTKFS>; Wed, 20 Mar 2002 05:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312146AbSCTKFI>; Wed, 20 Mar 2002 05:05:08 -0500
Received: from [62.245.135.174] ([62.245.135.174]:55947 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S312145AbSCTKE6>;
	Wed, 20 Mar 2002 05:04:58 -0500
Message-ID: <3C985EBF.D53B43A2@TeraPort.de>
Date: Wed, 20 Mar 2002 11:04:47 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre2-ac2-mkn i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andre Hedrick <andre@linux-ide.org>, Ken Brownfield <ken@irridia.com>,
        m.knoblauch@TeraPort.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
In-Reply-To: <E16nVId-0000yr-00@the-village.bc.nu>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 03/20/2002 11:04:47 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 03/20/2002 11:04:58 AM,
	Serialize complete at 03/20/2002 11:04:58 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I am in their lab trying to reproduce the error and I have found some docs
> > which could help address the error of the 4byte FIFO issue in the engine.
> > It looks fixable on paper.
> 
> Andre - if you want the info I have from the previous stuff I was involved
> in I can strip out customer company info and send it on.
> 
> > As for the AMD driver, who knows which version is in that kernel.
> 
> 2.4.18 has a very old one
> 2.4.18-ac has the Andre/AMD updated one, but not the further updates.
>                 (eg it turns off SWDMA on more chipsets than it needs to)
> 

 it is actually possible that the AMD driver is not enabled on the
kernel from our integrator. Could this give problems when someone
enables DMA on the IDE devices?


 I am still wondering why we did not see it on the eight other boxes
with the same setup. Maybe just luck?

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
