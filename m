Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTGAOgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTGAOgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:36:51 -0400
Received: from relay5.ftech.net ([195.200.0.100]:5536 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S262227AbTGAOgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:36:48 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25C961@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.22-pre2
Date: Tue, 1 Jul 2003 15:51:09 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,
	please can we have generic hdlc in 2.4.22.  I was very disappointed
that it didn't get into 2.4.21



Kevin Curtis
Linux Development
FarSite Communications Ltd
kevin.curtis@farsite.co.uk
tel:   +44 1256 330461
fax:  +44 1256 854931
http://www.farsite.co.uk

-----Original Message-----
From: Marc-Christian Petersen [mailto:m.c.p@wolk-project.de]
Sent: 27 June 2003 06:59
To: Marcelo Tosatti; lkml
Subject: Re: Linux 2.4.22-pre2


On Friday 27 June 2003 00:03, Marcelo Tosatti wrote:

Hi Marcelo,

> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
so why you don't merge this? This is now the 4th resend.

--------------------------------------------------------------------------
[PATCH 2.4.22-BK] [RESEND 3rd] Fix oom killer braindamage
Date: 21.06.2003 22:04
From: Marc-Christian Petersen <m.c.p@wolk-project.de>  (Working Overloaded 
Linux Kernel)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org

Hi Marcelo,

attached patch fixes the oom killer braindamage where it tries to kill 
processes again and again and again w/o any ending or successfull killing of

the selected processes in an OOM case.

The attached, very simple but effective, patch fixes it.

All the kudos go to Rik van Riel.

Patch tested and works, and also for a long time in my tree (and maybe also 
others?!)

This issue is out there for several years.

Please apply it for 2.4.22-pre2, thanks.
--------------------------------------------------------------------------

ciao, Marc
