Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUG1TY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUG1TY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUG1TY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:24:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54486 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263540AbUG1TYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:24:30 -0400
Date: Wed, 28 Jul 2004 12:23:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       fastboot@osdl.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <25870000.1091042619@flay>
In-Reply-To: <200407280903.37860.jbarnes@engr.sgi.com>
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com> <200407280903.37860.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, July 28, 2004 09:03:37 -0700 Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Tuesday, July 27, 2004 6:53 pm, Eric W. Biederman wrote:
>> Hmm.  I think this will require one of the kernels to run at a
>> non-default address in physical memory.
> 
> Right, and some platforms already support this, fortunately.
> 
>> Which will largely depend on the quality of it's device drivers...
> 
> I think this could end up being a good thing.  It gives more people a stake in 
> making sure that driver shutdown() routines work well.

We discussed this at kernel summit a bit - it'd be safer to make the devices
clear down on boot up, rather than shutdown, if possible ... less work to
do on the unstable base.

Maybe we could shut down the devices on bringup, then bring it up again 
(no I'm not kidding ;-)) ... should reuse the code.

M.



