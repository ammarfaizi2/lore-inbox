Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUALTsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUALTsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:48:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:56591 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265115AbUALTsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:48:36 -0500
Date: Mon, 12 Jan 2004 19:48:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Doug Ledford <dledford@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112194829.A7078@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
	Doug Ledford <dledford@redhat.com>, Peter Yao <peter@exavio.com.cn>,
	linux-kernel@vger.kernel.org,
	linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com> <20040112151230.GB5844@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040112151230.GB5844@devserv.devel.redhat.com>; from arjanv@redhat.com on Mon, Jan 12, 2004 at 04:12:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 04:12:30PM +0100, Arjan van de Ven wrote:
> > as the patch discussed in this thread, i.e. pure (partially
> > vintage) bugfixes.
> 
> Both SuSE and Red Hat submit bugfixes they put in the respective trees to
> marcelo already. There will not be many "pure bugfixes" that you can find in
> vendor trees but not in marcelo's tree.

I haven't seen SCSI patches sumission for 2.4 from the vendors on linux-scsi
for ages.  In fact I asked Jens & Doug two times whether they could sort out
the distro patches for the 2.4 stack and post them, but it seems they're busy
enough with real work so this never happened.

