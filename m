Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292389AbSCIBwK>; Fri, 8 Mar 2002 20:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292383AbSCIBwA>; Fri, 8 Mar 2002 20:52:00 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:21380 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S292384AbSCIBvv>; Fri, 8 Mar 2002 20:51:51 -0500
Message-ID: <3C896A97.7DA21DF9@didntduck.org>
Date: Fri, 08 Mar 2002 20:51:19 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS driver status
In-Reply-To: <E16jW9m-0008NH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > The GDT descriptors are private to the PNP BIOS and constant values once
> > > set up. No PnPBIOS call is made before the configuration is done.
> > >
> > > Seems ok to me - or am I missing something ?
> >
> > Two user processes calling functions through /proc...
> 
> The GDT descriptors are set up before /proc comes into being. I'm checking
> 2.4 code here - has someone left old stuff in 2.5 ?

PNP_TS1 and PNP_TS2 are changed on every call to the bios to point to
where the data for the 32-bit code lives.

-- 

						Brian Gerst
