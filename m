Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751729AbWB0LeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbWB0LeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWB0LeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:34:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:48548 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751198AbWB0LeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:34:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 27 Feb 2006 12:32:13 +0100
To: schilling@fokus.fraunhofer.de, chris@gnome-de.org
Cc: nix@esperi.org.uk, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, dhazelton@enter.net, davidsen@tmr.com,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <4402E33D.nailJ4D9185HJ@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <200602192053.25767.dhazelton@enter.net>
 <43F9F11E.nail5BM21M01Q@burner>
 <200602202311.29759.dhazelton@enter.net>
 <43FAED22.nailD1291Q4HS@burner>
 <1140810381.3160.44.camel@localhost.localdomain>
In-Reply-To: <1140810381.3160.44.camel@localhost.localdomain>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Neumair <chris@gnome-de.org> wrote:

> Am Dienstag, den 21.02.2006, 11:36 +0100 schrieb Joerg Schilling:
> > I did write some time ago that the most probable cause for the Linux
> > bug is that
> > Linux is sending uninitialized data for the amount of bytes that pad
> > to 12 byte.
>
> How are they supposed to be filled? I don't have a clue on the low-level
> stuff involved, but isn't this as simple as initializing the rest of the
> c array in idescsi_pc_t to 0?

They are supposed to be filled with null chars.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
