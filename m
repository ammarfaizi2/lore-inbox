Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267675AbUHJSxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267675AbUHJSxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267663AbUHJSv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:51:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20122 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267361AbUHJStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:49:08 -0400
Date: Tue, 10 Aug 2004 20:48:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: alan@lxorguk.ukuu.org.uk, diablod3@gmail.com, dwmw2@infradead.org,
       eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, skraw@ithnet.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810184858.GH19391@suse.de>
References: <200408101544.i7AFic0s014401@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101544.i7AFic0s014401@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, Joerg Schilling wrote:
> >From: Jens Axboe <axboe@suse.de>
> 
> >Don't be naive. How do you discuss changes with him? The one patch I did
> >create against the SUSE cdrecord for the one shipped with SL9.1 adds a
> >note to use ATA over ATAPI since that is preferred, and it kills the
> >silly open-by-devname warnings that are extremely confusing to users. I
> >did send that back to Joerg, to no avail.
> 
> You never send such mail.... but you told me that that you liked me to
> _remove_ warnings.  Note that I also output warnings on Solaris if
> users use suboptimal interfaces.

Ehm yes, aren't you contradicting yourself? Here's the mail I'm
referring to:

From: Jens Axboe <axboe@suse.de>
Date: Mon, 12 Jan 2004 16:50:16 +0100
To: schilling@fokus.fraunhofer.de
Subject: open by devname

[-- Attachment #1 --]
[-- Type: text/plain, Encoding: 7bit, Size: 0.3K --]

Hi Joerg,

With 2.6 and SG_IO for generic block devices, it's pretty annoying and
confusing to users that cdrecord outputs:

"Open by 'devname' is unintentional and not supported."

This leads them to think they did something wrong, which they really
didn't. Any chance you could be talked into taking that message out?

--------

Nothing fruitful came of it, so patch stayed in the SUSE rpm.

-- 
Jens Axboe

