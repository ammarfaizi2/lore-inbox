Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWBFQbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWBFQbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBFQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:31:25 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:6087 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932198AbWBFQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:31:25 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 06 Feb 2006 17:29:17 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43E7795D.nail81Y3TBMUC@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr>
 <43DE2FA8.nail16ZB1XOPF@burner>
 <Pine.LNX.4.61.0602051300430.11476@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602051300430.11476@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> I just found that the followig "works" (cdrom drive not supported, but 
> other than that seems fine) under Solaris 11 snv_30 x86, much to my 
> surprise:
>
>   cdrecord -dev=/dev/rdsk/c1t0d0p0 -toc
>
> which worked just as well as
>
>   cdrecord -dev=1,0,0 -toc
>
> I would have rather expected to get
>
>   Warning: Open by 'devname' is unintentional and not supported.

You are the first to try this unsupported dev parameter.

Fortunately, users on Solaris usually read the man pages before
doing wrong things and then it usually works....

Once I see to many people using this kind of CLI, I'll add a note.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
