Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWFSHv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWFSHv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWFSHv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:51:58 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:55993 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932217AbWFSHv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:51:58 -0400
Message-ID: <449656CE.9020401@aitel.hist.no>
Date: Mon, 19 Jun 2006 09:48:30 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>	<m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>	<20060609195750.GD10524@thunk.org> <4489D55F.20103@garzik.org> <m3k67q5boi.fsf@bzzz.home.net>
In-Reply-To: <m3k67q5boi.fsf@bzzz.home.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
>>>>>>             
>
>  JG> No, there is a key difference between ext3 and SCSI/etc.:  cruft is removed.
>
>  JG> In ext3, old formats are supported for all eternity.
>
> we'd need this anyway. just to let users to migrate.
>   
Not really.  Today, people use reiserfs even though they couldn't
just remount their old ext2 as reiserfs.

An ext2/ext3-incompatible ext4 isn't a problem.  Sure, people will
have to mkfs instead of just remounting, and that will mean fewer
quick conversions in the short-term.  But people using ext3 today
don't really need ext4 - they are per definition running on sufficiently
small disks/partitions.

So an incompatible ext4 will still see use - on new filesystems mostly.
Not a problem, people buy disks all the time.

Helge Hafting



