Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSLJTUo>; Tue, 10 Dec 2002 14:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSLJTUo>; Tue, 10 Dec 2002 14:20:44 -0500
Received: from intpop.corp.wcom.ca ([205.150.160.74]:19607 "EHLO corp.wcom.ca")
	by vger.kernel.org with ESMTP id <S262828AbSLJTUn> convert rfc822-to-8bit;
	Tue, 10 Dec 2002 14:20:43 -0500
Message-ID: <049101c2a082$50d45300$9c094d8e@wcom.ca>
From: "Serge Kuznetsov" <serge@wcom.ca>
To: "Dave Jones" <davej@codemonkey.org.uk>, <ebuddington@wesleyan.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <20021210111835.A92@ma-northadams1b-112.bur.adelphia.net> <20021210170939.GC577@codemonkey.org.uk> <03ad01c2a073$bc5e1200$9c094d8e@wcom.ca>
Subject: Re: 2.5.51 won't boot with devfs enabled
Date: Tue, 10 Dec 2002 14:28:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > I had the same problem with 2.5.50, avoidable by disabling devfs entirely.
> > 
> > Sounds similar to http://bugzilla.kernel.org/show_bug.cgi?id=110
> > Does enabling UNIX98 pty's fix your problem ?
> 
> I have the same issue, even with
> CONFIG_UNIX98_PTYS = Y
> CONFIG_DEVFS_FS = Y
> CONFIG_DEVFS_MOUNT = Y
> CONFIG_DEVFS_DEBUG = Y
> CONFIG_DEVPTS_FS = Y
> 
> I am trying to invistigate problem closely for now.
> 

I've got email with recomendations, and removed CONFIG_DEVFS_DEBUG. The issue has been solved.

All the Best!
Serge.
