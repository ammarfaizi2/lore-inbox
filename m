Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269304AbUIBXfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269304AbUIBXfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269307AbUIBXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:33:09 -0400
Received: from the-village.bc.nu ([81.2.110.252]:914 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269289AbUIBXbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:31:46 -0400
Subject: Re: The argument for fs assistance in handling archives (was:
	silent semantic changes with reiser4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Christer Weinigel <christer@weinigel.se>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040902214731.GF24932@mail.shareable.org>
References: <20040901200806.GC31934@mail.shareable.org>
	 <200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
	 <20040902173214.GB24932@mail.shareable.org>
	 <m3pt54il82.fsf@zoo.weinigel.se>
	 <20040902214731.GF24932@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094164023.6163.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 23:27:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 22:47, Jamie Lokier wrote:
>     - Can the daemon keep track of _every_ file on my disk like this?
>       That's more than a million files, and about 10^5 directories.
>       dnotify would require the daemon to open all the directories.
>       I'm not sure what inotify offers.

This is currently a real issue for both desktop search and for virus
scanners. They want a "what changed and where" system wide (or at least
per namespace/mount).


