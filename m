Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUG1SLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUG1SLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUG1SLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:11:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:46824 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261563AbUG1SLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:11:14 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Date: Wed, 28 Jul 2004 11:06:17 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, fastboot@osdl.org
References: <16734.1090513167@ocs3.ocs.com.au> <200407280903.37860.jbarnes@engr.sgi.com> <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281106.17626.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28, 2004 11:00 am, Eric W. Biederman wrote:
> > I think this could end up being a good thing.  It gives more people a
> > stake in making sure that driver shutdown() routines work well.
>
> Which actually is one of the items open for discussion currently.
> For kexec on panic do we want to run the shutdown() routines?

We'll have to do something about incoming dma traffic and other stuff that the 
devices might be doing.  Maybe a arch specific callout to do some chipset 
stuff?

Jesse
