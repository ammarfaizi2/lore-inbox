Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbTEAIfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 04:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTEAIfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 04:35:47 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30212 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261172AbTEAIfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 04:35:46 -0400
Date: Thu, 1 May 2003 08:47:51 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: arjanv@redhat.com, ricklind@us.ibm.com, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030501084751.A15867@devserv.devel.redhat.com>
References: <20030430121105.454daee1.akpm@digeo.com> <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com> <20030430162108.09dbd019.akpm@digeo.com> <1051778205.1406.0.camel@laptop.fenrus.com> <20030501014212.03d304e9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030501014212.03d304e9.akpm@digeo.com>; from akpm@digeo.com on Thu, May 01, 2003 at 01:42:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 01:42:12AM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > Nuking a kernel feature
> > (basically making sched_yield() more posix compliant) for ONE
> > broken-since-fixed app doesn't sound like a good plan to me.
> 
> You're promising there are no others?

I'm saying that about half the others will expect the new (posix) behavior
and half will expect the old linux behavior of yielding only 1 spot.
Whatever you do you can't win for everything; and the vast majority of the
apps out there will not even call this function themselves. Ever.
