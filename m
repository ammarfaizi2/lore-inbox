Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTHXCJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 22:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTHXCJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 22:09:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263611AbTHXCJz (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 22:09:55 -0400
Message-ID: <20030824020749.1349.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: "Tomasz Torcz" <zdzichu@irc.pl>, "LKML" <linux-kernel@vger.redhat.com>
Date: Sun, 24 Aug 2003 03:07:49 +0100
Subject: Re: 2.6.0-test4 - lost ACPI
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Tomasz Torcz <zdzichu@irc.pl> 
Date: 	Sun, 24 Aug 2003 00:04:38 +0200 
To: LKML <linux-kernel@vger.redhat.com> 
Subject: Re: 2.6.0-test4 - lost ACPI 
 
> On Sat, Aug 23, 2003 at 02:55:45PM -0700, Andrew Morton wrote: 
> > Tomasz Torcz <zdzichu@irc.pl> wrote: 
> >  
> > >  ACPI disabled because your bios is from 00 and too old 
> > >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
> >  
> > Add "acpi=force" to your kernel boot command line and everything should work 
> > as before. 
>  
> It does not work. It halts in beetween ps/2 mouse init and serio init. 
> Adding "acpi=force pci=noacpi" solves that. 
 
Yeah! I have the same problem on my P4 box. Please, take a look at: 
 
http://bugzilla.kernel.org/show_bug.cgi?id=1123ml/ 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
