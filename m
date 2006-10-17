Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWJQSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWJQSgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWJQSf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:35:59 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:35499 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750795AbWJQSf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:35:59 -0400
Date: Tue, 17 Oct 2006 20:32:04 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: ismail@pardus.org.tr
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <453521a4.QReHSjx3qh9sf0jr%Joerg.Schilling@fokus.fraunhofer.de>
References: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de>
 <200610172041.42873.ismail@pardus.org.tr>
 <45351d1d.zzAZVd00Wr6s9fu8%Joerg.Schilling@fokus.fraunhofer.de>
 <200610172128.20653.ismail@pardus.org.tr>
In-Reply-To: <200610172128.20653.ismail@pardus.org.tr>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez <ismail@pardus.org.tr> wrote:

> > Well, this is why I did offer a preliminary version of thelatest mkisofs
> > sources.....
>
> Well a simple mkisofs some_file > test.iso and mounting that on a loop device 
> worked fine.
>
>
> > But note: your patch does not fix the original implementation bug and it is
> > most unlikely that the hack will do the right things in all cases.
>
> Well I don't know whats the original implementation bug and rock.c seems to be 
> pretty much old with no active maintainer.

Please read again my original mail....

1) you need to create images with Rock Ridge

2) a correct implementation is prepared to deal with more recent versions 
	without a need for new changes.

So, if the implementation does not deal with the new version _without_ 
explicitely knowing about v1.12 it is still broken.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
