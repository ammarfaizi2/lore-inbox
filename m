Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVDZI0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVDZI0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVDZI0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:26:22 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:46510 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261387AbVDZI0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:26:14 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
From: Alexander Nyberg <alexn@dsv.su.se>
To: Patrick McHardy <kaber@trash.net>
Cc: Andi Kleen <ak@suse.de>, Ed Tomlinson <tomlins@cam.org>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <426D8587.6060507@trash.net>
References: <200504240008.35435.kernel-stuff@comcast.net>
	 <1114332119.916.1.camel@localhost.localdomain>
	 <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net>
	 <20050425153541.GC16828@wotan.suse.de>
	 <1114452899.2012.2.camel@localhost.localdomain>
	 <426D8587.6060507@trash.net>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 10:26:11 +0200
Message-Id: <1114503971.887.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-04-26 klockan 02:04 +0200 skrev Patrick McHardy:
> Alexander Nyberg wrote:
> > Usually gives in after about 20 minutes of gcc compiling, sometimes even
> > up to 40 minutes. I had 2.6.12-rc2 stand for 2-3 hours so it seems ok.
> > If anyone has a better recipe for it please do tell.
> 
> uml seems to trigger the bug faster, I'm usually seeing it within
> a couple of minutes. I'm doing a binary search now.

Ok, I'll try to compile UML, most of the times it doesn't work out for
me, but having something that triggers more reliably would be useful.
Sometimes it has taken even over an hour with gcc.

> > It doesn't appear to be any of the obvious patch candidates...
> 
> Which ones did you try?

freepgt series and everything that directly touches ia32 emulation
between rc2 and rc3. The problem is I have only my saved commit mails
right now and some x64 patches seem to be missing, I need to learn git
and start reversing stuff from there...

No snapshots available either, whoever introduced the bug chose a bad
timing ;-)

