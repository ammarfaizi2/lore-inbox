Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTKFR7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTKFR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:59:05 -0500
Received: from ns.suse.de ([195.135.220.2]:27583 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263785AbTKFR7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:59:01 -0500
Date: Thu, 6 Nov 2003 18:58:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031106175813.GQ437@suse.de>
References: <B179AE41C1147041AA1121F44614F0B0598CE5@AVEXCH02.qlogic.org> <20031106171409.GN437@suse.de> <1068140592.5234.8.camel@laptop.fenrus.com> <20031106175032.GO437@suse.de> <20031106185511.C15403@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106185511.C15403@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06 2003, Arjan van de Ven wrote:
> 
> On Thu, Nov 06, 2003 at 06:50:32PM +0100, Jens Axboe wrote:
> > drive it is not). Now both 2.4 and 2.6 make that guarentee. The only
> > argument for disabling clustering would be for 2.4 for CPU cycle
> > reasons.
> 
> yep; on 2.4 it's rather visible in the profiles during some benchmark
> test I did (like 5% of total CPU cycles)

yeah so I gather, although 5% seems extremely excessive (512-byte raw
io, on tons of disks?).

-- 
Jens Axboe

