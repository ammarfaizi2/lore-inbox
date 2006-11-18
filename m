Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756132AbWKRCER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbWKRCER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 21:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbWKRCER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 21:04:17 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:21775 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP
	id S1756132AbWKRCEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 21:04:16 -0500
Date: Sat, 18 Nov 2006 03:04:13 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Message-ID: <20061118020413.GD31268@vanheusden.com>
References: <20061118010946.GB31268@vanheusden.com>
	<slrnelsomr.dd3.olecom@flower.upol.cz>
	<20061118020200.GC31268@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118020200.GC31268@vanheusden.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sun Nov 19 00:08:47 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I found that sometimes processes disappear on some heavily used system
> > > of mine without any logging. So I've written a patch against 2.6.18.2
> > > which emits logging when a process emits a fatal signal.
> > Why not to patch default signal handlers in glibc, to have not only
> > stderr, but syslog, or /dev/kmsg copy of fatal messages?
> Afaik when a proces gets shot because of a segfault, also the libraries
> it used are shot so to say. iirc some of the more fatal signals are
> handled directly by the kernel.

Also: what about statically build programs?


Folkert van Heusden

-- 
Feeling generous? -> http://www.vanheusden.com/wishlist.php
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
