Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292338AbSCIBpj>; Fri, 8 Mar 2002 20:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292368AbSCIBpT>; Fri, 8 Mar 2002 20:45:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37892 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292338AbSCIBpN>; Fri, 8 Mar 2002 20:45:13 -0500
Subject: Re: PnP BIOS driver status
To: bgerst@didntduck.org (Brian Gerst)
Date: Sat, 9 Mar 2002 02:00:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jdthood@mail.com (Thomas Hood),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C896773.15325802@didntduck.org> from "Brian Gerst" at Mar 08, 2002 08:37:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jW9m-0008NH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The GDT descriptors are private to the PNP BIOS and constant values once
> > set up. No PnPBIOS call is made before the configuration is done.
> > 
> > Seems ok to me - or am I missing something ?
> 
> Two user processes calling functions through /proc...

The GDT descriptors are set up before /proc comes into being. I'm checking
2.4 code here - has someone left old stuff in 2.5 ?
