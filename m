Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWGCWAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWGCWAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWGCWAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:00:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932137AbWGCWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:00:00 -0400
Subject: Re: ext4 features
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomasz Torcz <zdzichu@irc.pl>, Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151964720.16528.22.camel@localhost.localdomain>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060701170729.GB8763@irc.pl>
	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
	 <20060703205523.GA17122@irc.pl>
	 <1151960503.3108.55.camel@laptopd505.fenrus.org>
	 <1151964720.16528.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 23:59:56 +0200
Message-Id: <1151963996.3108.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 23:12 +0100, Alan Cox wrote:
> Ar Llu, 2006-07-03 am 23:01 +0200, ysgrifennodd Arjan van de Ven:
> > raid is great for protecting against individual disks or sectors going
> > bad. But raid, especially high performance implementations, do not
> > checksum data or detect corruptions. 
> > 
> > They're different purpose with almost zero overlap in purpose or even
> > goal...
> 
> Same layer though - checksums are really a device mapper type problem
> rather than an fs type problem.

file payload checksums.. I'd agree
filesystem metadata.. there checksums do provide value 

