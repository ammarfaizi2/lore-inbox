Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTKEOha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 09:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTKEOha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 09:37:30 -0500
Received: from ns.suse.de ([195.135.220.2]:45705 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262927AbTKEOh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 09:37:26 -0500
Date: Wed, 5 Nov 2003 13:36:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix rq->flags use in ide-tape.c
Message-ID: <20031105123649.GN1477@suse.de>
References: <200311041718.hA4HIBmv027100@hera.kernel.org> <20031105084004.GY1477@suse.de> <200311051300.47039.bzolnier@elka.pw.edu.pl> <1068034491.5332.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068034491.5332.0.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Arjan van de Ven wrote:
> 
> > Yeah, it is ugly.  Using rq->cmd is also ugly as it hides the problem in
> > ide-tape.c, but if you prefer this way I can clean it up.  I just wanted
> > minimal changes to ide-tape.c to make it working.
> 
> isn't the right answer "use ide-scsi and scsi-tape" for IDE based tape
> drives ?

No comment :0

-- 
Jens Axboe

