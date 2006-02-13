Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWBMPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWBMPbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWBMPbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:31:04 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:36025 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750738AbWBMPbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:31:03 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:29:37 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0A5E1.nailKUS106KMUQ@burner>
References: <20060208162828.GA17534@voodoo>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <200602092221.56942.dhazelton@enter.net>
 <43F08C5F.nailKUSDKZUAZ@burner>
 <mj+md-20060213.140141.31817.atrey@ucw.cz>
In-Reply-To: <mj+md-20060213.140141.31817.atrey@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> Hello!
>
> > libscg abstracts from a kernel specific transport and allows to write OS 
> > independent applications that rely in generic SCSI transport.
> > 
> > For this reason, it is bejond the scope of the Linux kernel team to decide on 
> > this abstraction layer. The Linux kernel team just need to take the current
> > libscg interface as given as _this_  _is_ the way to do best abstraction.
>
> Do you really believe that libscg is the only way in the world how to
> access SCSI devices?
>
> How can you be so sure that the abstraction you have chosen is the only
> possible one?
>
> If an answer to either of this questions is NO, why do you insist on
> everybody bending their rules to suit your model?

Name me any other lib that is as OS independent and as clean/stable as
libscg is. Note that the interface from libscg did not really change 
since August 1986. 


> > The Linux kernel team has the freedom to boycott portable user space SCSI 
> > applications or to support them.
>
> That's really an interesting view ... if anybody is boycotting anybody,
> then it's clearly you, because you refuse to extend libscg to support
> the Linux model, although it's clearly possible.

Looks like you did not follow the discussion :-(

I am constantly working on better support for Linux while the Linux kernel
folks do not even fix obvious bugs.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
