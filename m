Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTELNJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTELNJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:09:31 -0400
Received: from angband.namesys.com ([212.16.7.85]:21121 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262112AbTELNJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:09:30 -0400
Date: Mon, 12 May 2003 17:22:09 +0400
From: Oleg Drokin <green@namesys.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: axboe@suse.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Oliver Neukum <oliver@neukum.org>, lkhelp@rekl.yi.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512132209.GB4165@namesys.com>
References: <200305121455.58022.oliver@neukum.org> <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, May 12, 2003 at 03:16:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Just a note that we have found TCQ unusable on our IBM drives and we had
> > > some reports about TCQ unusable on some WD drives.
> > > Unusable means severe FS corruptions starting from mount.
> > > So if your FSs will suddenly start to break, start looking for cause with
> > > disabling TCQ, please.
> > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69
> TCQ is marked EXPERIMENTAL and is known to be broken.
> Probably it should be marked DANGEROUS or removed?

How do you think people will test code that is removed?
Or do you mean that nobody plans to look at this ever?
I remember that Jens Axboe promised to take a look at it some
months ago.

Bye,
    Oleg
