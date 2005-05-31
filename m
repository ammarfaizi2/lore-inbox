Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVEaMzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVEaMzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVEaMzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:55:42 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40920 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261609AbVEaMsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:48:23 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 May 2005 14:47:00 +0200
To: schilling@fokus.fraunhofer.de, dtor_core@ameritech.net
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429C5CC4.nail6R619E90N@burner>
References: <4847F-8q-23@gated-at.bofh.it>
 <d120d500050527072146c2e5ee@mail.gmail.com>
 <429AD7ED.nail4ZG1B42TI@burner>
 <200505301727.43926.dtor_core@ameritech.net>
In-Reply-To: <200505301727.43926.dtor_core@ameritech.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> > So let me sum up: Never rely on things that cannot be made 100%
> > unique in case you like to run security relevent software like cdrecord.
>
> Are you talking about <bus>,<target>,<lun> numbering by any chance ;) ?
> Because for the most types of devices out there they don't make any sense
> and just provided for compatibility with legacy software.

Well, this is the way most OS on the planet deal with SCSI. 

And please explain me why the Linux kernel internally uses these numbers
for driver instancing? Is the Linux kernel a piece of legacy software?


> Also, from a bit different perspective - do you also want users to mount
> the CD they burnt using not device (/dev/xxx) but <bus>,<target>,<lun>?
> If not why writing application should use different addressing? 

Using SCSI addresses is just the way that works more universally for
sending SCSI commands. There are several OS that don't support /dev/ names
and all other UNIX like OS do not artificial hide the SCSI addresses 
from userland programs.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
