Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGQsu>; Wed, 7 Feb 2001 11:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129214AbRBGQsl>; Wed, 7 Feb 2001 11:48:41 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:10252 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129026AbRBGQsa>; Wed, 7 Feb 2001 11:48:30 -0500
Date: Wed, 07 Feb 2001 11:48:16 -0500
From: Chris Mason <mason@suse.com>
To: David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <479040000.981564496@tiny>
In-Reply-To: <20010207083854.F24270@spoke.nols.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 07, 2001 08:38:54 AM -0800 David Rees
<dbr@spoke.nols.com> wrote:

> On Wed, Feb 07, 2001 at 10:47:09AM -0500, Chris Mason wrote:
>> 
>> Ok, how about we list the known bugs:
>> 
>> zeros in log files, apparently only between bytes 2048 and 4096 (not
>> reproduced yet).
> 
> Could this bug be related to the reported corruption that people with
> new VIA chipsets have been also reporting on ext2?  It seems similar
> because of the location of the corruption:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=98147483712620&w=2
> 
> Anyway, it can't hurt to ask the bug reported if they're using a
> newer VIA chipset and see if they will upgrade their BIOS which seems
> to fix the problem.

I'd love to blame this on VIA problems, but people are seeing it on other
chipsets too ;-)  

People who report this aren't seeing general corruption, just zeros in
files of specific sizes.  So, it really should be a reiserfs bug.

-chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
