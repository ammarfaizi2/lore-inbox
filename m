Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTDNWPM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbTDNWPM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:15:12 -0400
Received: from zeke.inet.com ([199.171.211.198]:26287 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S263978AbTDNWPL (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:15:11 -0400
Message-ID: <3E9B35B1.1020809@inet.com>
Date: Mon, 14 Apr 2003 17:26:57 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] patch splitting util(s)?
References: <3E9B2C38.4020405@inet.com> <20030414215128.GA24096@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Apr 14, 2003 at 04:46:32PM -0500, Eli Carter wrote:
> 
>  > I didn't have much luck with googling.  I think the words I used are too 
>  > generic.  :/
>  
> Google for diffsplit. Its part of Tim Waugh's patchutils.
> Patchutils should be part of pretty much every distro these days too.

I'm aware of patchutils.  (Check the 0.2.22 Changelog ;) )  However, 
splitdiff doesn't do what I'm after, from my initial look.  Though now 
that I think about it, it suggests an alternative solution.  A 
'shatterdiff' that created one diff file per hunk in a patch would give 
me basically what I want.  I could then use directories and 'mv' to sort 
out the parts.  Repetative calls to 'combinediff' would suffice for 
cleaning up the ensuing mess, I think.  Hmm...  That would get me to the 
hunk level, but not the sub-hunk, though editdiff/rediff might help there.

Thanks,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

