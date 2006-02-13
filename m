Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWBMNmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWBMNmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWBMNmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:42:13 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:22474 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750938AbWBMNmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:42:12 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 14:40:47 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F08C5F.nailKUSDKZUAZ@burner>
References: <20060208162828.GA17534@voodoo>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <200602092221.56942.dhazelton@enter.net>
In-Reply-To: <200602092221.56942.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > Name a single program (not using libscg) that implements user space SCSI
> > and runs on as many platforms as cdrecord/libscg does.
>
> I'm not the maintainer of a program, and hence I don't have to.
>
> But why in the hell do you even _need_ SCSI in userspace when the kernel 
> provides complete facilities? And even then your argument is specious, since 

Then please try to inform yourself in order to understand that you are wrong.


libscg abstracts from a kernel specific transport and allows to write OS 
independent applications that rely in generic SCSI transport.

For this reason, it is bejond the scope of the Linux kernel team to decide on 
this abstraction layer. The Linux kernel team just need to take the current
libscg interface as given as _this_  _is_ the way to do best abstraction.

The Linux kernel team has the freedom to boycott portable user space SCSI 
applications or to support them.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
