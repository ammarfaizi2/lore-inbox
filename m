Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422749AbWBNSR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWBNSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWBNSR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:17:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26073 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422749AbWBNSR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:17:58 -0500
Date: Tue, 14 Feb 2006 19:17:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, drepper@redhat.com,
       austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
In-Reply-To: <43F21D84.8010907@zytor.com>
Message-ID: <Pine.LNX.4.61.0602141916370.32490@yvahk01.tjqt.qr>
References: <43EEACA7.5020109@zytor.com> <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
 <43F09320.nailKUSI1GXEI@burner> <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr>
 <43F1F2C2.nailMWZGOQDYR@burner> <Pine.LNX.4.61.0602141907030.32490@yvahk01.tjqt.qr>
 <43F21D84.8010907@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > > Do you have a better proposal for naming the interfaces?
>> > > chownfn maybe. (fd + name)
>> > I am not shure if this would match the rules from the Opengroup.
>> > Solaris has these interfaces since at least 5 years.
>> This is not the cdrecord thread so Solaris is a no-go in this very one.
>
> FWIW, I think the -at() suffix is just fine, and well established by now (yes,
> there is shmat, but the SysV shared memory interfaces are bizarre to begin with
> -- hence POSIX shared memory which has real names.)
>
Yep. Someday, Linux - or rather glibc! for that matter, as it is the one 
which translates FUNCTIONNAME() into a syscall -- will be like the Windows 
API. Full of compatibility stuff. And you can't do anything about it :)


Jan Engelhardt
-- 
