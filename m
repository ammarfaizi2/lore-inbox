Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVFAPOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFAPOC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFAPOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:14:02 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:41427 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261407AbVFAPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:13:08 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 17:11:50 +0200
To: schilling@fokus.fraunhofer.de, kraxel@suse.de
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DD036.nail7BF7MRZT6@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org>
In-Reply-To: <87acmbxrfu.fsf@bytesex.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@suse.de> wrote:

> Joerg Schilling <schilling@fokus.fraunhofer.de> writes:
>
> > If you use /dev/ entries to directly address SCSI targets, then you 
> > are relying on on assumptions that cannot be granted everywhere.
> >
> > Cdrecord is portable and this needs to implement a way that is portable 
> > and does not rely on nonportable assumptions like yours.
>
> Not really.  Yes, it runs on different operating systems.  But to send
> the SCSI commands to the device you have OS-specific code in there,
> simply because it's handled in different ways on Solaris / Linux /
> whatever OS.  You could make the device addressing OS-specific as well
> instead of expecting everyone in the world follow the Solaris model,
> that would make life a bit easier for everyone involved.

This is not the Solaris model....

I did define this model 19 years ago when I did write the first 
Generic SCSI driver at all. Adaptec indepentently did develop ASPI
2 years later and did chose the same address model. Nearly all
OS use this kind (or a very similar model) internaly inside the kernel
or the basic SCSI address routines.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
