Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946537AbWJSVqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946537AbWJSVqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946539AbWJSVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 17:46:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40578 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946537AbWJSVqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 17:46:54 -0400
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Cc: 7eggert@gmx.de, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org, kronos.it@gmail.com, ismail@pardus.org.tr
In-Reply-To: <4537f093.TLaIyXNS8h2a3uF9%Joerg.Schilling@fokus.fraunhofer.de>
References: <771eN-VK-9@gated-at.bofh.it> <771yn-1XU-65@gated-at.bofh.it>
	 <E1GZy4L-00015O-AV@be1.lrz>
	 <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
	 <Pine.LNX.4.58.0610182023100.2145@be1.lrz>
	 <4536b8dc.nfxUMeg8jVJ9WF95%Joerg.Schilling@fokus.fraunhofer.de>
	 <Pine.LNX.4.58.0610192256460.2316@be1.lrz>
	 <4537f093.TLaIyXNS8h2a3uF9%Joerg.Schilling@fokus.fraunhofer.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 22:49:19 +0100
Message-Id: <1161294559.17335.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 23:39 +0200, ysgrifennodd Joerg Schilling:
> Wrong inode numbes do not open holes, they just create a garbage in garbage out
> behavior, but they will not cause the OS to panic. 

Thats implementation dependant as people who stress OS environments and
do fuzz testing have provided again and again and again - including a
previous Linux over ext3 case. There isn't exactly any hurry - its
evident from the lack of reports that you are the first tool author
whose beta tool even uses this feature.

> The unfixed bugs in the Linux iso-9660 implementation on the other side allow 
> me to create a CD that causes Linux to panic without taking me a long time.

And those should indeed be fixed.

