Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUG1QSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUG1QSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUG1QLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:11:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:2784 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267263AbUG1QIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:08:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Date: Wed, 28 Jul 2004 09:03:37 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, fastboot@osdl.org
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407280903.37860.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 27, 2004 6:53 pm, Eric W. Biederman wrote:
> Hmm.  I think this will require one of the kernels to run at a
> non-default address in physical memory.

Right, and some platforms already support this, fortunately.

> Which will largely depend on the quality of it's device drivers...

I think this could end up being a good thing.  It gives more people a stake in 
making sure that driver shutdown() routines work well.

Jesse
