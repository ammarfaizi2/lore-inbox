Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTLRVtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTLRVti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:49:38 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:13279 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265373AbTLRVth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:49:37 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Fri, 19 Dec 2003 08:49:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16354.8417.289020.412015@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MD Raid fixed? was: Linux 2.6.0
In-Reply-To: message from Mike Fedyk on Thursday December 18
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
	<20031217211516.2c578bab.akpm@osdl.org>
	<20031218194537.GF6438@matchmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 18, mfedyk@matchmail.com wrote:
> On Wed, Dec 17, 2003 at 09:15:16PM -0800, Andrew Morton wrote:
> > - There are significant changes in the module subsystem, the LVM (Device
> >   Mapper) and RAID subsystems.  Details about these and many other kernel
> 
> There was a thread against 2.6.test11 about some issues with MD & DM.  Also
> there was one report of problems with ext3+MD.
> 
> I don't use LVM or DM, so I'm interested in the second case.

There was a raid5 problem that could trigger under xfs or any
filesystem over DM, and the fix for that is in 2.6.0

I am not aware of a problem with ext3 over MD without DM in between.

NeilBrown
