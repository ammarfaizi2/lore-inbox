Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266026AbUAQKBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAQKBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:01:53 -0500
Received: from holomorphy.com ([199.26.172.102]:27818 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266026AbUAQKBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:01:52 -0500
Date: Sat, 17 Jan 2004 02:01:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>, Steve Gonczi <steve@relicore.com>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: kgdb 2.0.4 with restructuring and fixes
Message-ID: <20040117100127.GI1332@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Amit S. Kale" <amitkale@emsyssoft.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, Tom Rini <trini@kernel.crashing.org>,
	George Anzinger <george@mvista.com>,
	Steve Gonczi <steve@relicore.com>, Matt Mackall <mpm@selenic.com>
References: <200401171451.38701.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401171451.38701.amitkale@emsyssoft.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 02:51:38PM +0530, Amit S. Kale wrote:
> kgdb 2.0.4 is available at http://kgdb.sourceforge.net ChangeLog below.
> Thanks.
> Amit Kale
> EmSysSoft (http://www.emsyssoft.com)
> KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)
> 2004-01-17 Tom Rini <trini@kernel.crashing.org>
> 	* Some restructuring to allow architectures to provide different
> 	serial infos to the kgdb serial interface.
> 2004-01-17 Pavel Machek <pavel@suse.cz>
> 	* Cleanups
> 	* changed calling convention from 0 on success, 1 on failure to 0 on
> 	success, -ERRNO on fail to be more consistent with rest of kernel
> 	* Made kgdb waiting for connection message KERN_CRIT
> 	* export kern_schedule only if CONFIG_KGDB_THREAD is defined

This sound great. Any chance you could splatter this out at a patch
series to lkml for those of us so entrenched in pre-1994 conventions
(such as myself) as to dislike chasing URL's from mailing list posts?


-- wli
