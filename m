Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292061AbSBOJ2A>; Fri, 15 Feb 2002 04:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292062AbSBOJ1r>; Fri, 15 Feb 2002 04:27:47 -0500
Received: from copper.ftech.net ([212.32.16.118]:47881 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S292061AbSBOJ1a>;
	Fri, 15 Feb 2002 04:27:30 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E4214@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Including the FarSync X.21 driver in the 2.2.x Kernel 
Date: Fri, 15 Feb 2002 09:22:30 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
	please find a patch against the 2.2.19 Kernel that includes support
for the FarSync X.21 driver.  This driver will allow syncppp over a
X21/V35/V24 line interface.  The driver is already included in the 2.4.x
Kernel.  As the patch is quite large it is downloadable from
 
http://www.farsite.co.uk/custsupp/download/FarSync_X21_Linux/farsync_2.2_pat
ch

As this is the first patch I have submitted, please let me know if there is
any problems with the presentation.  When do you anticipate a release of
2.2.20?  Will this patch be included in that release?

Regards

Kevin Curtis
Linux Development
FarSite Communications Ltd
kevin.curtis@farsite.co.uk
tel:   +44 1256 330461
fax:  +44 1256 331145


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: 18 January 2002 09:58
To: kevin.curtis@farsite.co.uk
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: Is the 2.2.x Kernel still being developed


> 	If this is possible, do I just mail a patch to you for it's
> inclusion?

Yep

> 	Will the module automatically be carried forward into the next
> stable version (2.6.x)?

2.6 or whatever it becomes will be from 2.5 which in turn starts from a 2.4
copy as of 2.4.14 (with the later changes merged in). Your driver is thus
already in the 2.5 development tree. The only thing you probably want to do
as 2.6 approaches is to ensure its still up to date, test it and submit
any fixes
