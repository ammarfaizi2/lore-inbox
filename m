Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVBEBFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVBEBFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264985AbVBEBFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:05:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58515 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266623AbVBDWJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:09:57 -0500
Date: Fri, 4 Feb 2005 22:09:49 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Pavel Machek <pavel@ucw.cz>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
In-Reply-To: <20050204163019.GC1290@elf.ucw.cz>
Message-ID: <Pine.LNX.4.56.0502042206090.26459@pentafluge.infradead.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
 <20050204163019.GC1290@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > int video_helper(struct video_actions *what_to_do)
> 
> I do not know, synchronously executing userland code from kernel seems
> like wrong thing to do.

I'm not a fan for this either. The good news is most graphics cards don't 
require these tricks. The only ones that do are the ix86 cards. The real 
solution would be if the hradware vendors open the parts of the spec to do 
what we need. Many of the older cards could be supported in this way if we
talk to the vendors. They shouldn't care if the specs are released anymore. 
The problem would be the latest Radeon card and NVIDIA cards which 
unfortunely are the most common cards for x86 platforms ;-(
