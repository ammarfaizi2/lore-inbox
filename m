Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWIVPkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWIVPkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWIVPky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 11:40:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932604AbWIVPky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 11:40:54 -0400
Date: Fri, 22 Sep 2006 11:40:35 -0400
From: Dave Jones <davej@redhat.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
Message-ID: <20060922154035.GB22531@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
References: <20060921192427.GD17065@redhat.com> <200609220717.k8M7H0Ir021258@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609220717.k8M7H0Ir021258@auster.physics.adelaide.edu.au>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 04:47:00PM +0930, Jonathan Woithe wrote:
 
 > > Given a machine check happened, the state of the machine in general
 > > is questionable.  I'd recommend a run of memtest86+ 
 > 
 > That was already done.  No memory errors were reported over 10 passes.
 > 
 > Secondly, the machine check indication was only present on one of the two
 > oopses we saw.  Furthermore, there was no indication in any log files
 > that a machine check had occurred in the case of the second oops.
 > Then again, perhaps machine checks don't get logged which would make this
 > observation irrelevant.
 > 
 > Could we be looking at a dying CPU?

Maybe. Or some other hardware problem. Insufficient cooling/power for eg.

	Dave
