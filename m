Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTEAPcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTEAPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:32:16 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15120
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261409AbTEAPcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:32:15 -0400
Subject: Re: must-fix list for 2.6.0
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, viro@parcelfarce.linux.theplanet.co.uk,
       ricklind@us.ibm.com, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
In-Reply-To: <20030501072703.A3705@infradead.org>
References: <20030430121105.454daee1.akpm@digeo.com>
	 <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	 <20030430162108.09dbd019.akpm@digeo.com>
	 <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
	 <20030430165914.2facc464.akpm@digeo.com>
	 <20030501072703.A3705@infradead.org>
Content-Type: text/plain
Message-Id: <1051803866.17629.57.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 01 May 2003 11:44:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 02:27, Christoph Hellwig wrote:

> No, they're doing it themselves.  The RedHat OO package has a patch to
> fix this mess (and two dozend other patches to work around OO braindamage..)

Right, Open Office is its own problem.

But LinuxThreads uses sched_yield() to do synchronization (yuck), since
it lacked something like futexes at the time.

	Robert Love

