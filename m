Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUJETDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUJETDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUJETDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:03:01 -0400
Received: from fmr04.intel.com ([143.183.121.6]:41180 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263664AbUJETCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:02:55 -0400
Date: Tue, 5 Oct 2004 12:02:25 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       jeffpc@optonline.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       trivial@rustcorp.com.au, rusty@rustcorp.com.au, greg@kroah.com
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper call
Message-ID: <20041005120224.A28582@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20041003162012.79296b37.akpm@osdl.org> <20041004102220.A3304@unix-os.sc.intel.com> <20041004123725.58f1e77c.akpm@osdl.org> <20041004124355.A17894@unix-os.sc.intel.com> <20041005012556.A22721@unix-os.sc.intel.com> <20041005101823.223573d9.akpm@osdl.org> <20041005102706.A27795@unix-os.sc.intel.com> <20041005104744.59177aea.akpm@osdl.org> <20041005110112.B27795@unix-os.sc.intel.com> <20041005112309.1215b350.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041005112309.1215b350.akpm@osdl.org>; from akpm@osdl.org on Tue, Oct 05, 2004 at 11:23:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 11:23:09AM -0700, Andrew Morton wrote:
> Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:

Andrew,
	My patch which removes cpu_run_sbin_hotplug() to use kobject_hotplug() works
fine with your patch which modifies kobject_hotplug().
I am able to get the same cpu "offline" notifications to user land.

You can safely apply both of our patches.

Thanks and regards,
Anil

