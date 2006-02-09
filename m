Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWBIR3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWBIR3q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWBIR3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:29:46 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:21656 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932513AbWBIR3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:29:45 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 09 Feb 2006 18:28:26 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EB7BBA.nailIFG412CGY@burner>
References: <200602031724.55729.luke@dashjr.org>
 <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >> >Please explain me:
> >> >
> >> >-	how to use /dev/hd* in order to scan an image from a scanner
> >> >-	how to use /dev/hd* in order to talk to a CPU device
> >> >-	how to use /dev/hd* in order to talk to a tape device
> >> >-	how to use /dev/hd* in order to talk to a printer
> >> >-	how to use /dev/hd* in order to talk to a jukebox
> >> >-	how to use /dev/hd* in order to talk to a graphical device
> >> >
> >> With /dev/sg, this was possible?
> >
> >Of course!
> >
> But you need to open the correct /dev/sg[0-9] too, don't you?
> (otherwise cdrecord would set the jukebox on fire)

This is why the mapping engine is in the Linux adoption part of
libscg. It maps the non-stable device <-> /dev/sg* relation to a
stable b,t,l address.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
