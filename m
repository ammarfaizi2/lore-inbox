Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310929AbSCROKv>; Mon, 18 Mar 2002 09:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310920AbSCROKm>; Mon, 18 Mar 2002 09:10:42 -0500
Received: from 216-42-72-146.ppp.netsville.net ([216.42.72.146]:52158 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S310963AbSCROKa>; Mon, 18 Mar 2002 09:10:30 -0500
Date: Mon, 18 Mar 2002 09:09:19 -0500
From: Chris Mason <mason@suse.com>
To: r.ems@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 freezes on heavy IO
Message-ID: <2183930000.1016460559@tiny>
In-Reply-To: <3C95F129.7D9744B5@gmx.net>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, March 18, 2002 02:52:41 PM +0100 Richard Ems <r.ems.mtg@gmx.net> wrote:

> Hi all!
> 
> I'm seeing my system freeze on heavy IO. Only the reset button brings it
> back to life again (ALT-SysRq-b also worked once). I'm running SuSE's
> 2.4.18-30 on a Pentium III (Coppermine) with 256 MB RAM (yes, I should
> try vanilla 2.4.18, I will ...)
> No SCSI, all IDE. LVM and ext3.

Which rpm?  k_i386, k_deflt, k_psmp, k_smp?  This is probably the
(aa specific) ext3 deadlock recently fixed by andrea and andrew.

-chris


