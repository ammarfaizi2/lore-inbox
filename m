Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUG1SBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUG1SBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 14:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUG1SBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 14:01:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64695 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261184AbUG1SBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 14:01:17 -0400
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, fastboot@osdl.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 12:00:31 -0600
In-Reply-To: <200407280903.37860.jbarnes@engr.sgi.com>
Message-ID: <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> writes:

> On Tuesday, July 27, 2004 6:53 pm, Eric W. Biederman wrote:
> > Hmm.  I think this will require one of the kernels to run at a
> > non-default address in physical memory.
> 
> Right, and some platforms already support this, fortunately.
> 
> > Which will largely depend on the quality of it's device drivers...
> 
> I think this could end up being a good thing.  It gives more people a stake in 
> making sure that driver shutdown() routines work well.

Which actually is one of the items open for discussion currently.
For kexec on panic do we want to run the shutdown() routines?

Eric
