Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUG1Lhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUG1Lhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 07:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUG1Lhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 07:37:53 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:47622 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S266882AbUG1Lhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 07:37:46 -0400
Date: Wed, 28 Jul 2004 12:38:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: gene.heskett@verizon.net, viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Message-ID: <10D3E6305A14470B62191D9B@sig-9-145-17-80.uk.ibm.com>
In-Reply-To: <200407280720.21518.gene.heskett@verizon.net>
References: <200407271233.04205.gene.heskett@verizon.net>
 <200407271315.22075.gene.heskett@verizon.net>
 <20040727192615.GG12308@parcelfarce.linux.theplanet.co.uk>
 <200407280720.21518.gene.heskett@verizon.net>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just had another crash/lockup, running 2.6.8-rc2-bk3
> At the instant, I was looking thru the menu's of the new
> kde3.3-beta2, in the window decoration, themes etc menu,
> where it got 14% loaded in a 60 megabyte file and it went
> away.

Confused.  Previously (below) you were running 2.6.8-rc2 so the problem was
in that version but not in -rc1 if I read you correctly.  So I would expect
you to be testing 2.6.8-rc1-bkN snapshots to see where your breakage was
introduced.

> I have now had 4 crashes while running 2.6.8-rc2, the last one
> requiring a full powerdown before the intel-8x0 could
> re-establish control over the sound.
[...]
> I'd revert to rc1, but I'd have to figure out a way to use this .config

As viro put it:

>It goes like that:
>2.6.7
>2.6.7 + 7-bk<n>
>2.6.7 + 8-rc1
>2.6.7 + 8-rc1 + 8-rc1-bk<n>
>2.6.7 + 8-rc2
>2.6.7 + 8-rc2 + 8-rc2-bk<n>

-apw
