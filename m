Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUG1TpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUG1TpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUG1TpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:45:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:62934 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263019AbUG1To7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:44:59 -0400
Date: Wed, 28 Jul 2004 12:42:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       fastboot@osdl.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <35250000.1091043768@flay>
In-Reply-To: <200407281106.17626.jbarnes@engr.sgi.com>
References: <16734.1090513167@ocs3.ocs.com.au> <200407280903.37860.jbarnes@engr.sgi.com> <m1bri06mgw.fsf@ebiederm.dsl.xmission.com> <200407281106.17626.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I think this could end up being a good thing.  It gives more people a
>> > stake in making sure that driver shutdown() routines work well.
>> 
>> Which actually is one of the items open for discussion currently.
>> For kexec on panic do we want to run the shutdown() routines?
> 
> We'll have to do something about incoming dma traffic and other stuff that the 
> devices might be doing.  Maybe a arch specific callout to do some chipset 
> stuff?

I vote for sleeping for 5 seconds ;-) Should kill off most of it ...

M.

