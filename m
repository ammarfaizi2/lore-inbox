Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTLDKhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTLDKhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:37:55 -0500
Received: from fmr06.intel.com ([134.134.136.7]:54748 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261298AbTLDKhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:37:54 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lhms-devel] RE: memory hotremove prototype, take 3
Date: Thu, 4 Dec 2003 02:37:10 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DD6A@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] RE: memory hotremove prototype, take 3
Thread-Index: AcO6TKFvCUypGpm5QNK4ivm/+BFIjAABESmg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Yasunori Goto" <ygoto@fsw.fujitsu.com>, <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Dec 2003 10:37:10.0820 (UTC) FILETIME=[92B92E40:01C3BA52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz]


> > I still think we could use the CPU's virtualization mechanism--of course,
> > and as you and Tony Luck mention, we'd had to track down and modify the
> > parts that assume physical memory et al. That they use large pages
> > or
> 
> ...which means basically auditing whole kernel, and rewriting half of
> drivers. Good luck with _that_.

Bingo...just the perfect excuse I need to give to my manager to keep
a low profile while tinkering around for a long time :)

Okay, so I will play a wee bit more the devil's advocate as an 
exercise of futility, if you don't mind. Just trying to compile a 
(possibly incomplete) quick list of what would be needed, can you 
guys help me? you know way more than I do:

1) the core kernel needs to be independent of physical memory position
1.1) same with drivers/subsystems
1.2) filesystems
[it cannot be really incomplete because I have added all the code :/]

Oh well, forget it, that's more than enough. Another project for the
stack of interesting things to work on.

Thanks to all

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
