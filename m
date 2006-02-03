Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWBCJ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWBCJ52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBCJ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:57:28 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:34288 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932206AbWBCJ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:57:27 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 10:55:16 +0100
To: xavier.bestel@free.fr, schilling@fokus.fraunhofer.de
Cc: oliver@neukum.org, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E32884.nail5CA1O92YA@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43DF3C3A.nail2RF112LAB@burner>
 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
 <200601311333.36000.oliver@neukum.org>
 <1138867142.31458.3.camel@capoeira> <43E1EAD5.nail4R031RZ5A@burner>
 <1138880048.31458.31.camel@capoeira> <43E20047.nail4TP1PULVQ@burner>
 <1138885334.31458.42.camel@capoeira>
In-Reply-To: <1138885334.31458.42.camel@capoeira>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> wrote:

> On Thu, 2006-02-02 at 13:51, Joerg Schilling wrote:
> > Xavier Bestel <xavier.bestel@free.fr> wrote:
> > > Well ... from your sayings it seems Linux is supported by HAL but not by
> > > libscg. 
> > 
> > Libscg is _the_ HAL for cdrecord. It is availaible the same way as today since
> > 10 years.
>
> I understand your point, but believe me, *nobody* wants one HAL per
> application. There need to be only one HAL for all, and as freedesktop's
> HAL has the functionnality necessary for cdrecord (minus perhaps a few

If people don't want this confusion, why do they start with a new system?

libscg & cdrecord have been available long before Linux HAL was there.

And the most important argument here is that it is extremely unlikely that
this Linux HAL will handle all oddities of all CD/DVD-writers, do it is 
unapropriate to use this interface in case that you like to get more 
information than just "the drive is there".

Note that UNIX people usually believe that is is best practice to have this 
kind of software intergrated in the kernel (or at leat in the system). This is 
what FreeBSD did try for some years, and FreeBSD has failed with this attempt.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
