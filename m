Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUIKRX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUIKRX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUIKRX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:23:28 -0400
Received: from the-village.bc.nu ([81.2.110.252]:44211 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268225AbUIKRXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:23:21 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409111304300.15792@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <1094883136.6095.75.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409110305070.13840@node2.an-vo.com>
	 <1094913414.21157.65.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409111144590.15458@node2.an-vo.com>
	 <1094915671.21290.77.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409111304300.15792@node2.an-vo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094919630.21082.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 17:20:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 18:10, Vladimir Dergachev wrote:
> This is a good point - if we don't need DMA or 3d acceleration we can 
> reduce memory footprint. This would seem that current DRM driver would 
> need to be dependent on whatever driver contains the mode setting code.
> 
> What do you think ?

Jon wants to get mode setting into a seperate piece of functionality -
preferably in user space for many cards. I'd dearly love to see hotplug
handing all but some "emergency" pre-computed mode settings.

Alan

