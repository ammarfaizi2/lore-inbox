Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTEFOB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTEFOAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:00:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263730AbTEFN7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:59:31 -0400
Date: Tue, 6 May 2003 16:11:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030506141153.GB25901@suse.de>
References: <Pine.LNX.4.44.0305061552520.1235-100000@neptune.local> <Pine.LNX.4.44.0305061608050.959-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305061608050.959-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Pascal Schmidt wrote:
> On Tue, 6 May 2003, Pascal Schmidt wrote:
> 
> > I'll check if reading from the MO drive works with ide-cd under 2.4
> > as well. If it does: what about a patch that makes ATAPI MO drives
> > and CD writers behave the same on 2.4: read-only with native ide drivers,
> > read-write with ide-scsi?
> 
> I can now confirm that using the MO drive read-only with 2.4 and ide-cd
> also works fine.
> 
> Could we please have this patch included in the 2.4 IDE code to make
> MO drives and CD writers behave the same?

Not until you fix ide-cd to correctly identify it. This half-assed
solution wont do.

-- 
Jens Axboe

