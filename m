Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUHRMuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUHRMuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUHRMuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:50:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59645 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265038AbUHRMuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:50:14 -0400
Date: Wed, 18 Aug 2004 17:58:28 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [RFC]Kexec based crash dumping
Message-ID: <20040818122828.GA3597@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817154436.529ba9f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817154436.529ba9f6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Aug 17, 2004 at 03:44:36PM -0700, Andrew Morton wrote:
> Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
> >
> > The patches that follow contain the initial implementation for kexec based
> > crash dumping that we are working on.
> 
> It seems to be coming together nicely.
> 
> Where do we stand with support for other architectures?  Do you expect that
> each architecture will involve a lot of work?

I don't think so. The main architecture dependent components are register
snapshotting and silencing of other cpus. These are not new problems to
solve as other projects such as LKCD, KDB have already done this for
most archs.

> 
> And how much of the i386 implementation do you expect x86_64 can
> reuse?

We should be able to re-use most of the code. The x86_64 port should be 
ready pretty quickly once kexec itself is available.

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
