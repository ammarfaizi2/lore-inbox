Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUC3Wo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUC3Wmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:42:39 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:40095 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261576AbUC3Wl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:41:29 -0500
Date: Tue, 30 Mar 2004 14:41:27 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040330224127.GA1469@dingdong.cryptoapps.com>
References: <20040319153554.GC2933@suse.de> <200403201723.11906.bzolnier@elka.pw.edu.pl> <1079800362.11062.280.camel@watt.suse.com> <200403201805.26211.bzolnier@elka.pw.edu.pl> <1080662685.1978.25.camel@sisko.scot.redhat.com> <1080674384.3548.36.camel@watt.suse.com> <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com> <20040330223625.GA1245@dingdong.cryptoapps.com> <4069F71E.1040801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4069F71E.1040801@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 05:39:26PM -0500, Jeff Garzik wrote:

> I'm suspicious of this, because of Bart's point...  I haven't seen
> any PATA disks that did FUA, so it sounds like broken software.

I was kinda hoping that the response would be "all modern SATA and
PATA dirves" because ideally this would be a nice thing to have.
Maybe we should just test in a few places and see if it works (timing
will show obviously).


