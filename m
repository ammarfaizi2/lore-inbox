Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422894AbWJRXcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbWJRXcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423101AbWJRXci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:32:38 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:54526 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1422894AbWJRXci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:32:38 -0400
Date: Thu, 19 Oct 2006 01:29:32 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: 7eggert@gmx.de
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kronos.it@gmail.com, ismail@pardus.org.tr, 7eggert@gmx.de
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <4536b8dc.nfxUMeg8jVJ9WF95%Joerg.Schilling@fokus.fraunhofer.de>
References: <771eN-VK-9@gated-at.bofh.it>
 <771yn-1XU-65@gated-at.bofh.it> <E1GZy4L-00015O-AV@be1.lrz>
 <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
 <Pine.LNX.4.58.0610182023100.2145@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0610182023100.2145@be1.lrz>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:

> On Wed, 18 Oct 2006, Joerg Schilling wrote:
> > Bodo Eggert <7eggert@elstempel.de> wrote:
>
> > > BTW2, Just to be cautionous: what will happen if somebody forces the same
> > > inode number on two different entries?
>
> [...]
> > This is something you cannot check.
>
> Exactly that's why I'd ignore the on-disk "inode number" and instead use
> the generated one untill someone comes along with a clever idea to fix
> the issue or can show that it's mostly hermless.

I could understand you in case that Linux would do some basic consistency checks
in the iso-9660 code already.....

Show me another program besides mkisofs that implements inode numbers _and_ does
it wrong.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
