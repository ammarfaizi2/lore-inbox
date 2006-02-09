Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbWBIJlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbWBIJlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWBIJlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:41:15 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:4269 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S965221AbWBIJlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:41:14 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 09 Feb 2006 10:39:55 +0100
To: schilling@fokus.fraunhofer.de, jim@why.dont.jablowme.net
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EB0DEB.nail52A1LVGUO@burner>
References: <200602031724.55729.luke@dashjr.org>
 <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo>
In-Reply-To: <20060208165330.GB17534@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> > You just verify that you don't listen...
>  
> Yes, I have been listening and I haven't seen you list one reason why
> cdrecord absolutely has to use SCSI IDs when fsck can get away with using
> /dev/blah just fine.

Are you _really_ missing basic know how to understand that fsck is using the
block layer of a virtual "block device" emulated by UNIX while libscg is
offering _direct_ acces to _any_ type of device allowing you to send _commands_
understood by the device?

fsck is just sending abstract instructions to a virtual device and does 
not care about 

Please explain me:

-	how to use /dev/hd* in order to scan an image from a scanner

-	how to use /dev/hd* in order to talk to a CPU device

-	how to use /dev/hd* in order to talk to a tape device

-	how to use /dev/hd* in order to talk to a printer

-	how to use /dev/hd* in order to talk to a jukebox

-	how to use /dev/hd* in order to talk to a graphical device

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
