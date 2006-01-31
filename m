Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWAaKxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWAaKxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWAaKxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:53:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31737 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750740AbWAaKxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:53:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 Jan 2006 11:47:27 +0100
To: schilling@fokus.fraunhofer.de, psusi@cfl.rr.com
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DF403F.nail2RF310RP6@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <20060129112613.GA29356@merlin.emma.line.org>
 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
 <43DD2A8A.nailGVQ115GOP@burner>
 <787b0d920601291328k52191977h37 <43DE495A.nail2BR211K0O@burner>
 <43DE75F5.40900@cfl.rr.com>
In-Reply-To: <43DE75F5.40900@cfl.rr.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:

> Joerg Schilling wrote:
> > I am sorry to see your recent dicussion style.
> >
> > I was asking a question and I did get a completely useless answer as
> > any person who has some basic know how Linux SCSI would know that
> > doing a stat("/dev/sg*", ...) will not return anything useful.
> >   
>
> It certainly does return something useful, just not what you are looking 
> for.  It does not return information that allows you to cleanly build 
> your bus:device:lun view of the world, but it does return sufficient 
> information to enumerate and communicate with all devices in the 
> system.  Is that not sufficient to be able to implement cdrecord?  If it 
> is, then the real issue here is that you want Linux to conform to the 
> bus:device:lun world view, which it seems many people do not wish to do. 

It does not allow libscg to find all devices.

> Maybe it would be more constructive if you were to make a good argument 
> for why the bus:device:lun view is better than /dev/*, but right now it 
> seems to me that they are just two different ways of doing the same 
> thing, and you prefer one way while the rest of the Linux developers 
> prefer the other. 

It would help if someone would give arguments why Linux does treat all 
SCSI devices equal, except for ATAPI transport based ones.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
