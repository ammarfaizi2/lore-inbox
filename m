Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUAWS6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUAWS6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:58:41 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:24238 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266613AbUAWS6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:58:40 -0500
Date: Fri, 23 Jan 2004 19:58:35 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
Message-ID: <Pine.LNX.4.55.0401231954430.3223@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0401222014390.1296-100000@neptune.local>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, Pascal Schmidt wrote:

> I've tested it with a 230 MB MO disc, which uses 512 byte sectors.
> I filled the whole disk, then ejected - reinsert - fsck - read and
> compare. Everything worked without problems. Then I inserted a
> 640 MB MO disc, which uses 2048 byte sectors, and went through the
> same procedure. No problems either, so switching between different
> sector sizes appears to work.

 Hmm, given MO is a removable direct access device, I'd suppose ide-floppy
would be used as the handling driver similarly to the Zip drive, wouldn't
it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
