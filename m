Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTJRTew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJRTew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:34:52 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:12946 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261797AbTJRTes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:34:48 -0400
Message-ID: <008801c395ac$f99c00d0$fb457dc0@tgasterix>
Reply-To: "Thomas Giese" <Thomas.Giese@gmx.de>
From: "Thomas Giese" <Thomas.Giese@gmx.de>
To: "Sean Neakums" <sneakums@zork.net>
Cc: <linux-kernel@vger.kernel.org>
References: <003b01c395a8$22dbf270$fb457dc0@tgasterix><6uy8viz7bs.fsf@zork.zork.net><006a01c395ab$4d3f34c0$fb457dc0@tgasterix> <6uu166z6qo.fsf@zork.zork.net>
Subject: Re: X crashes under linux-2.6.0-test7-mm1
Date: Sat, 18 Oct 2003 21:21:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Seen: false
X-ID: VUfVZuZErePMZAMbL8KXznwRr8zIq-dfrq-BqPOEWAewMRti6yntUC@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, i'll try to compile it into kernel, not as module,
there was already something with unresolved symbols
in XFS, JFS and ethernet-card (3c59x) also runs only when not loaded as
module.

thanks again

thomas

-----Ursprüngliche Nachricht----- 
Von: "Sean Neakums" <sneakums@zork.net>
An: "Thomas Giese" <Thomas.Giese@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Gesendet: Samstag, 18. Oktober 2003 21:27
Betreff: Re: X crashes under linux-2.6.0-test7-mm1


> "Thomas Giese" <Thomas.Giese@gmx.de> writes:
>
> > both are set to
> > CONFIG_AGP=m
> > CONFIG_AGP_INTEL=m
>
> Were they loaded when you started X?  The message:
>
> (EE) Unable to open /dev/agpgart (No such device)
>
> suggests that they were not.

