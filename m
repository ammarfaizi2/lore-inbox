Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWBMO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWBMO7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWBMO7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:59:08 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:47255 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932112AbWBMO7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:59:07 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 15:57:43 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F09E67.nailKUSQCAD6I@burner>
References: <20060208162828.GA17534@voodoo>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner>
 <mj+md-20060213.104344.18941.atrey@ucw.cz>
In-Reply-To: <mj+md-20060213.104344.18941.atrey@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> Hello!
>
> > This was true until ~ 2001, when Linux introduced unstable USB handling.
>
> Even before that point it wasn't true, adding a new controller card
> could always result in renumbering the previously existing controllers.

Even in this case, this was a deficit from Linux.

On Solaris, adding a new controler always asigns this new controler a new
higher ID (except for the case when the sysadmin explicitly requests different 
behavior). On Linux a sysadmin needs to know how the evaluation works....

And BTW: if a sysadmin does not know how things work on Linux and thus
causes a remapping, all /etc/vfstab entries would be void. So you are talking 
about a major fault that should be avoided under all circumstances.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
