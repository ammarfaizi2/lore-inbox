Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUC3Wci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUC3Wch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:32:37 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:54971 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261427AbUC3Wcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:32:35 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] barrier patch set
Date: Wed, 31 Mar 2004 00:40:43 +0200
User-Agent: KMail/1.5.3
Cc: Chris Mason <mason@suse.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com>
In-Reply-To: <4069F2FC.90003@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403310040.43034.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 of March 2004 00:21, Jeff Garzik wrote:
> Stephen C. Tweedie wrote:
> > Yep.  It scares me to think what performance characteristics we'll start
> > seeing once that gets used everywhere it's needed, though.  If every raw
> > or O_DIRECT write needs a flush after it, databases are going to become
> > very sensitive to flush performance.  I guess disabling the flushing and
> > using disks which tell the truth about data hitting the platter is the
> > sane answer there.
>
> For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't
> return until the data is on the platter.

Do you know of any drive supporting it?  I don't.

Bartlomiej

