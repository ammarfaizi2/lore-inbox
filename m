Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTI3TJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbTI3TJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:09:16 -0400
Received: from codepoet.org ([166.70.99.138]:17798 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261670AbTI3TJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:09:10 -0400
Date: Tue, 30 Sep 2003 13:09:08 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jens Axboe <axboe@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Andreas Steinmetz <ast@domdv.de>,
       schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930190908.GC5407@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jens Axboe <axboe@suse.de>, "David S. Miller" <davem@redhat.com>,
	Andreas Steinmetz <ast@domdv.de>, schilling@fokus.fraunhofer.de,
	linux-kernel@vger.kernel.org
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930052337.444fdac4.davem@redhat.com> <20030930122832.GO2908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930122832.GO2908@suse.de>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 30, 2003 at 02:28:32PM +0200, Jens Axboe wrote:
> Well then change that to 'if you include kernel headers from your user
> apps, be prepared to pick fix the breakage'.
> 
> Surely the kernel doesn't move at such an accelerated pace that it's
> impossible to keep kernel headers uptodate.

A classic recent example is iproute, which uses kernel headers
all over the place.  It compiled with earlier 2.4.x kernels, but
it no longer compiles 2.4.22.  I've not bothered to try and fix
it, but if it included its own set of sanitized kernel headers,
it would not have had a problem.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
