Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVCCAtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVCCAtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVCCApW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:45:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5822 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261372AbVCCAov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:44:51 -0500
Message-ID: <42265DEA.1030004@pobox.com>
Date: Wed, 02 Mar 2005 19:44:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> 
>>30?  Try 310 changesets, in my netdev-2.6 pending queue.
> 
> 
> Note that I don't think a 2.6.<even> would have problems with things like 
> driver updates.

Nah, I agree with DaveJ -- there are definitely "dev" portions when it 
comes to driver updates.

Judging from recent posting from Bart, it looks like he has an evil plot 
to merge the IDE driver with libata.  libata will also eventually 
[perhaps with Bart's changes?] make the SCSI portion optional, as I have 
long promised.  And it's getting other new and destabilizing features.

There will be other changes in SCSI and block too, which want staging... 
  Some of the stuff I've been putting off until "2.7" will be re-thought 
into something that appears in the on-going 2.6 series.

If you don't have driver stability, you don't have a useful kernel...

	Jeff



