Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTEMS3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEMS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:29:19 -0400
Received: from havoc.daloft.com ([64.213.145.173]:18392 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262357AbTEMS3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:29:18 -0400
Date: Tue, 13 May 2003 14:42:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513184205.GC11073@gtf.org>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de> <20030513180020.GB3309@suse.de> <20030513180334.GJ17033@suse.de> <20030513180459.GB11073@gtf.org> <20030513180651.GK17033@suse.de> <20030513181337.GM17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513181337.GM17033@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:13:37PM +0200, Jens Axboe wrote:
> btw, you may want to see the IDE_TCQ_FIDDLE_SI define in ide-tcq, here's
> the comment I put there:
> 
> /*
>  * we are leaving the SERVICE interrupt alone, IBM drives have it
>  * on per default and it can't be turned off. Doesn't matter, this
>  * is the sane config.
>  */
> #undef IDE_TCQ_FIDDLE_SI
> 
> Are you sure this isn't what you are seeing?


My information comes solely from IDENTIFY DEVICE...

	Jeff



