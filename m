Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266121AbUGOGNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbUGOGNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUGOGNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:13:19 -0400
Received: from holomorphy.com ([207.189.100.168]:41634 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266114AbUGOGNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:13:14 -0400
Date: Wed, 14 Jul 2004 23:12:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       mikpe@csd.uu.se, B.Zolnierkiewicz@elka.pw.edu.pl, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-ID: <20040715061254.GP3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, mikpe@csd.uu.se,
	B.Zolnierkiewicz@elka.pw.edu.pl, dgilbert@interlog.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200407141751.i6EHprhf009045@harpo.it.uu.se> <40F57D14.9030005@pobox.com> <20040714143508.3dc25d58.akpm@osdl.org> <20040715055655.GE9383@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715055655.GE9383@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>>> Or you could just call it "gcc is dumb" rather than a compiler bug.

On Wed, Jul 14 2004, Andrew Morton wrote:
[... code snippet ...]
>> is pretty dumb too.  I don't see any harm if this compiler feature/problem
>> pushes us to fix the above in the obvious way.

On Thu, Jul 15, 2004 at 07:56:56AM +0200, Jens Axboe wrote:
> Excuse my ignorance, but why on earth would that be dumb? Looks
> perfectly legit to me, and I have to agree with Jeff that the compiler
> is exceedingly dumb if it fails to inline that case.

Enter gcc...

Maybe "the obvious way" is sending a someone off to whip gcc into shape,
or possibly reporting it as a gcc problem.


-- wli
