Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266412AbUALQFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266433AbUALQFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:05:14 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:32384 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266412AbUALQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:05:03 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: James Bottomley <James.Bottomley@steeleye.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Martin Peschke3 <MPESCHKE@de.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <1073922773.3114.275.camel@compaq.xsintricity.com>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
	<20040112141330.GH24638@suse.de>
	<1073920110.3114.268.camel@compaq.xsintricity.com>
	<1073921054.2186.16.camel@mulgrave>  <20040112154345.GE1255@suse.de> 
	<1073922773.3114.275.camel@compaq.xsintricity.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jan 2004 11:04:17 -0500
Message-Id: <1073923459.2186.23.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 10:52, Doug Ledford wrote:
> Well, the scsi-dledford-2.4 tree is intended to be someplace I can put
> all the stuff I'm having to carry forward in our kernels, so that's
> distinctly different than a driver update only tree.  I could do that
> separately and I have no problem doing that.

I'll take that as a "yes" then ;-)

Thanks for doing this, beacuse I really wasn't looking forward to trying
to sort it all out.

>  As for the other stuff,
> I'm not pushing to necessarily get any of my changes into mainline.  I
> would be happy if they make it there sometime as that would relieve load
> off of me, but at the same time I *am* making some changes to the core
> code (sorry Jens, but there are some ways in which the 2.4 core scsi
> code is just too broken to believe and leaving it broken just means
> dealing with everyone that points it out in bugzilla entries) and I know
> people are loath to change core code in mainline, so I kinda figured a
> lot of that stuff would either A) stay separate or B) only after myself
> and other interested parties agree on a patch and that patch is widely
> tested and known good then maybe it might get moved over, up to Marcelo.

I trust your judgement about this, so it sounds like we have the
beginnings of a good working model for 2.4

James


