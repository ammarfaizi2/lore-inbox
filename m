Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422926AbWBIRhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWBIRhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422922AbWBIRht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:37:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52960 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422926AbWBIRhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:37:48 -0500
Date: Thu, 9 Feb 2006 18:37:44 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, peter.read@gmail.com,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43EB7D8A.1030906@gmx.de>
Message-ID: <Pine.LNX.4.61.0602091837100.30108@yvahk01.tjqt.qr>
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner>
 <43EB7D8A.1030906@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>
>>> But you need to open the correct /dev/sg[0-9] too, don't you?
>>> (otherwise cdrecord would set the jukebox on fire)
>> 
>> This is why the mapping engine is in the Linux adoption part of
>> libscg. It maps the non-stable device <-> /dev/sg* relation to a
>> stable b,t,l address.
>
>Well, the b,t,l mapping, judging from libscg code, is as stable as the
>ordering of the device nodes themselves, so it is not clear what the
>advantage would be other than getting a uniform and artificial b,t,l mapping.
>
>If hotplugging shuffles /dev/sg* between running $APPLICATION -scanbus and
>$APPLICATION -dowhatever, the b,t,l will change as well.
>

Don't interrupt my (trick) thread (as explained before in private).
Thank you.



Jan Engelhardt
-- 
