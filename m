Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTKEMWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 07:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTKEMWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 07:22:22 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12477 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262893AbTKEMWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 07:22:21 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: arjanv@redhat.com
Subject: Re: [PATCH] fix rq->flags use in ide-tape.c
Date: Wed, 5 Nov 2003 13:26:56 +0100
User-Agent: KMail/1.5.4
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311041718.hA4HIBmv027100@hera.kernel.org> <200311051300.47039.bzolnier@elka.pw.edu.pl> <1068034491.5332.0.camel@laptop.fenrus.com>
In-Reply-To: <1068034491.5332.0.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311051326.56668.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 of November 2003 13:14, Arjan van de Ven wrote:
> > Yeah, it is ugly.  Using rq->cmd is also ugly as it hides the problem in
> > ide-tape.c, but if you prefer this way I can clean it up.  I just wanted
> > minimal changes to ide-tape.c to make it working.
>
> isn't the right answer "use ide-scsi and scsi-tape" for IDE based tape
> drives ?

NO!!!

