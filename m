Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUFXGKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUFXGKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXGKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:10:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:6868 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263875AbUFXGJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:09:36 -0400
Date: Wed, 23 Jun 2004 23:09:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
Message-ID: <20040623230933.M22989@build.pdx.osdl.net>
References: <1088010468.5806.52.camel@lade.trondhjem.org> <20040623122930.K22989@build.pdx.osdl.net> <1088020210.5806.95.camel@lade.trondhjem.org> <20040623144150.H21045@build.pdx.osdl.net> <1088031727.8944.71.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1088031727.8944.71.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Wed, Jun 23, 2004 at 07:02:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> So what do we do? There is no way that we can keep the current rules, as
> they provide no consistent way to inform the underlying NFS or CIFS
> filesystem  when to test for lock->fl_pid, when to test for
> lock->fl_owner, and when to test for lock->fl_file.

No bright ideas here.  Each avenue I tried tonight was a dead end.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
