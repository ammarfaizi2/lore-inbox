Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWFIQ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWFIQ3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWFIQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:29:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25487 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750707AbWFIQ3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:29:00 -0400
Message-ID: <4489A1C6.7040402@garzik.org>
Date: Fri, 09 Jun 2006 12:28:54 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <44899D93.5030008@garzik.org> <20060609162403.GA26709@harddisk-recovery.com>
In-Reply-To: <20060609162403.GA26709@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Fri, Jun 09, 2006 at 12:10:59PM -0400, Jeff Garzik wrote:
>> Alex Tomas wrote:
>>> I believe it's as stable as before until you mount with extents
>>> mount option.
>> If it will remain a mount option, if it is never made the default 
>> (either in kernel or distro level), then only 1% of users will ever use 
>> the feature.  And we shouldn't merge a 1% use feature into the _main_ 
>> filesystem for Linux.
> 
> Why not? That's how htree dir indexing got in, and AFAIK most distros
> use it as a default.

The question is not today's usage, but long term production usage.  If 
it is destined to be default eventually, then it's not a 1% case.

	Jeff



