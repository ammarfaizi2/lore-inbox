Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWGCVzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWGCVzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWGCVzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:55:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25778 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932083AbWGCVzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:55:36 -0400
Subject: Re: ext4 features
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tomasz Torcz <zdzichu@irc.pl>, Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151960503.3108.55.camel@laptopd505.fenrus.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 23:12:00 +0100
Message-Id: <1151964720.16528.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 23:01 +0200, ysgrifennodd Arjan van de Ven:
> raid is great for protecting against individual disks or sectors going
> bad. But raid, especially high performance implementations, do not
> checksum data or detect corruptions. 
> 
> They're different purpose with almost zero overlap in purpose or even
> goal...

Same layer though - checksums are really a device mapper type problem
rather than an fs type problem.

Alan

