Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTEVQa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTEVQa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:30:56 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:37581 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262776AbTEVQaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:30:55 -0400
Date: Thu, 22 May 2003 18:43:49 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030522164349.GA17830@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030522163448.GA17004@ranty.ddts.net> <Pine.LNX.4.44.0305220937370.5889-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305220937370.5889-100000@cherise>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 09:38:55AM -0700, Patrick Mochel wrote:
> 
> >  Sorry. Since it is small I'll simply split class-casts+release.diff and
> >  attach both pieces just in case.
> 
> Thanks.
> 
> >  If I had to choose I would take drivers/base/firmware/
> 
> Ok. Maybe I mis-read that part of the patch; I thought there was more than 
> one file. No worries, then. 

 Actually it is two files:

 	firmware_class.c:
		the code itself
	firmware_sample_driver.c:
		sample code for driver writers.

 If you don't like having firmware_sample_driver.c there, it could be
 moved to Documentation/ or put in some web page.

 Thanks

 	Manuel

 
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
