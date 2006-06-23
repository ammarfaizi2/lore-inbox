Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWFWDFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWFWDFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFWDFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:05:24 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:646 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751105AbWFWDFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:05:24 -0400
Date: Fri, 23 Jun 2006 12:07:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, jeremy@goop.org,
       rdunlap@xenotime.net, clameter@sgi.com, ntl@pobox.com,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] avoid cpu removal if busy revisited
Message-Id: <20060623120706.49522965.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060622195409.1ea44604.akpm@osdl.org>
References: <20060623105058.96937576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060622195409.1ea44604.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 19:54:09 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Fri, 23 Jun 2006 10:50:58 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > +static int test_cpu_busy(int cpu)
> > ...
> > +		if (moderate_cpu_removal && test_cpu_bust(cpu))
> 
> I love the function name but alas, the linker will not.
> 
Sorry, my refreshing process was bad.

> Let's treat this as an [rfc].  Please test the final version carefully.

Ah, yes. I should add  [RFC] to subject, reviews from cpu-hotplug people 
are welcome.

-Kame

