Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVEaLGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEaLGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVEaLGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:06:06 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:25028 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261806AbVEaLF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:05:58 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 May 2005 13:03:31 +0200
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com
Cc: toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429C4483.nail5X0215WJQ@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
In-Reply-To: <46BE0C64-1246-4259-914B-379071712F01@mac.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:

> > BTW: an implementation that uses something like Solaris does with
> > /etc/path_to_inst and puts USB serial numbers into the path_to_inst
> > kernel instance database could come very close to the desired result
> > and would give stable SCSI addresses too.
>
> But why fix what isn't broken?  I can tell all my other programs, from
> dd to mount, that I want to use the udev-created /dev/green_burner, so
> why do you indicate such usage is _deprecated_ in cdrecord?  For such
> device nodes, a _filesystem_ is the preferred name=>number index, so
> why add an extra strange file "just because Solaris does".

If you use /dev/ entries to directly address SCSI targets, then you 
are relying on on assumptions that cannot be granted everywhere.

Cdrecord is portable and this needs to implement a way that is portable 
and does not rely on nonportable assumptions like yours.


> And why again do you need stable SCSI addresses for my _USB_ drive?

Well if the udev program was polite to users, it would also support
to edit /etc/default/cdrecord...... 

... if it _really_ does wat you like with /dev/ links, then it has all 
the information that is needed to also maintain /etc/default/cdrecord



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
