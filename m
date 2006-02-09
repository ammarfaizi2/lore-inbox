Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422915AbWBIRPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422915AbWBIRPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbWBIRPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:15:19 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39574 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422915AbWBIRPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:15:17 -0500
Date: Thu, 9 Feb 2006 18:15:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43EB7210.nailIDH2JUBZE@burner>
Message-ID: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Please explain me:
>> >
>> >-	how to use /dev/hd* in order to scan an image from a scanner
>> >-	how to use /dev/hd* in order to talk to a CPU device
>> >-	how to use /dev/hd* in order to talk to a tape device
>> >-	how to use /dev/hd* in order to talk to a printer
>> >-	how to use /dev/hd* in order to talk to a jukebox
>> >-	how to use /dev/hd* in order to talk to a graphical device
>> >
>> With /dev/sg, this was possible?
>
>Of course!
>
But you need to open the correct /dev/sg[0-9] too, don't you?
(otherwise cdrecord would set the jukebox on fire)


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
