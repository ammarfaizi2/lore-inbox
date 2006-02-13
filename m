Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWBMPup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWBMPup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWBMPuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:50:44 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:1234 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750745AbWBMPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:50:43 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:49:23 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0AA83.nailKUS171HI4B@burner>
References: <20060208162828.GA17534@voodoo>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner>
 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
 <43F0A010.nailKUSR1CGG5@burner>
 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
In-Reply-To: <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> > Sformat already includes such a mapping if you are on Solaris.
> > Unfortunately this does cleanly work on Linux and for this
> > reason is did not make it into cdrecord.
>
> Jorg,
>
> thanks for your answer.
>
> I fail to understand how it is connected to my proposal. Maybe we
> misunderstood each other.
>
> I assume that you refer to the sformat/fmt.c implementation (sformat
> 3.5) being reproduced in cdrecord/scsi_scan.c (latest cdrtools).
>
> Could you please elaborate on:
> - what does the sformat scanbus code has to do with my proposal, whose
> changes would mostly be located in the libscg modules, not in the
> cdrecord module

What has your proposal to do with libscg and how would you like to implement
it OS independent?

> - why 'it' doesn't clearly work on Linux. cdrecord clearly creates
> this os specific to b,t,l mapping (e.g. in scsi-linux-ata.c,
> scsi-wnt.c etc..). Why this mapping cannot be publicised in a
> parseable format?

Name a method that would work for anhy type of devices and any of the
supported 21 OS.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
