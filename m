Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVL2ESt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVL2ESt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 23:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVL2ESt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 23:18:49 -0500
Received: from thorn.pobox.com ([208.210.124.75]:18064 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S965012AbVL2ESs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 23:18:48 -0500
Date: Wed, 28 Dec 2005 22:18:39 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Sonny Rao <sonny@burdell.org>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, clameter@sgi.com, anton@samba.org,
       shai@scalex86.org, sonnyrao@us.ibm.com, alokk@calsoftinc.com
Subject: Re: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051229041838.GA2934@localhost.localdomain>
References: <20051219051659.GA6299@kevlar.burdell.org> <20051222092743.GE3915@localhost.localdomain> <20051222173700.GA5723@localhost.localdomain> <20051222175311.GA22393@kevlar.burdell.org> <20051222183750.GA3704@localhost.localdomain> <20051222194511.GB24385@kevlar.burdell.org> <20051228193012.GF12674@localhost.localdomain> <20051229003025.GA30666@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229003025.GA30666@kevlar.burdell.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:
> On Wed, Dec 28, 2005 at 01:30:12PM -0600, Nathan Lynch wrote:
> > 
> > Does removing the #include of asm-generic/topology.h from the bottom
> > of asm-powerpc/topology.h have any effect?
> 
> Hi, no it doesn't make a difference.  That include is protected by
> CONFIG_NUMA as well, so it never gets hit.  At Anton's suggestion I
> even put in an #error into asm-generic/topology.h to make sure it
> wasn't an issue -- it didn't hit.

Gah, sorry, forgot Anton fixed this a while back.

