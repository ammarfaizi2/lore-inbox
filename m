Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWBCMz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWBCMz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWBCMz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:55:59 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:10887 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750756AbWBCMz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:55:59 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jiri Slaby <xslaby@fi.muni.cz>, kavitha s <wellspringkavitha@yahoo.co.in>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602021750510.13212@yvahk01.tjqt.qr>
References: <1138863068.3270.6.camel@laptopd505.fenrus.org>
	 , <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <20060202105338.E921D22AF07@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602021750510.13212@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 13:55:49 +0100
Message-Id: <1138971350.3086.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 17:51 +0100, Jan Engelhardt wrote:
> >>> > ds: no socket drivers loaded!
> >>> > VFS: Cannot open root device "LABEL=/" or 00:00
> >>> change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
> >>
> >>ehhh??
> >>sure it does.
> >>
> >>this is not a kernel feature, but an initrd feature, independent on
> >>which kernel is used (there never was and is not a patch for this in any
> >>distro kernel I know about)
> >Ok, thank you for pointing that out.
> >
> 
> So does someone have a kernel-side patch for enabling LABEL=?

I'm not aware of one existing.

>  (Is the 
> kernel even able to tell the label of a filesystem, or is that specific to 
> mount(8)?)

currently the kernel is fully unaware of any labels, other than having
the space reserved in the various filesystem on disk metadata.



This is one of those things that is better done in userspace really.....


