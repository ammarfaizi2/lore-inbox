Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266112AbUALJWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUALJWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:22:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47065 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266111AbUALJWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:22:35 -0500
Date: Mon, 12 Jan 2004 10:22:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112092231.GG29177@suse.de>
References: <4002CC23.6000105@exavio.com.cn> <1073898527.4428.1.camel@laptop.fenrus.com> <20040112091903.GD24638@suse.de> <20040112091946.GA29779@suse.de> <20040112092059.GC6677@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112092059.GC6677@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12 2004, Arjan van de Ven wrote:
> On Mon, Jan 12, 2004 at 10:19:46AM +0100, Jens Axboe wrote:
> > 
> > ... and still exists in your 2.4.21 based kernel.
> 
> The RHL 2.4.21 kernels don't have the locking patch at all...

But RHEL3 does:

http://kernelnewbies.org/kernels/rhel3/SOURCES/linux-2.4.21-iorl.patch

and the bug is there.

-- 
Jens Axboe

