Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVATWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVATWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVATWWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:22:25 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:1216 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262174AbVATWWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:22:19 -0500
Subject: Re: LVM2
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Alasdair G Kergon <agk@redhat.com>
Cc: Norbert van Nobelen <Norbert@edusupport.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20050120220252.GA14097@agk.surrey.redhat.com>
References: <1106250687.3413.6.camel@localhost.localdomain>
	 <200501202240.02951.Norbert@edusupport.nl>
	 <20050120220252.GA14097@agk.surrey.redhat.com>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 15:22:14 -0700
Message-Id: <1106259735.3413.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PV = the device
VG = groups of them (the RAID5 array?)
LV = what? the file system?

So, from what you are telling me, and the man page, 2.6.x with LVM2 can
have basically any size of PV, VG, and LV I want.

Am I flawed in my understanding?

Thank you,
Trever

On Thu, 2005-01-20 at 22:02 +0000, Alasdair G Kergon wrote:
> On Thu, Jan 20, 2005 at 10:40:02PM +0100, Norbert van Nobelen wrote:
> > A logical volume in LVM will not handle more than 2TB. You can tie together 
> > the LVs in a volume group, thus going over the 2TB limit. 
> 
> Confused over terminology?
> Tie PVs together to form a VG, then divide VG up into LVs.
> 
> Size limit depends on metadata format and the kernel: old LVM1 format has 
> lower size limits - see the vgcreate man page.
> 
> New LVM2 metadata format relaxes those limits and lets you have LVs > 2TB
> with a 2.6 kernel.
> 
> Alasdair
--
"Assassination is the extreme form of censorship." -- George Bernard
Shaw (1856-1950)

