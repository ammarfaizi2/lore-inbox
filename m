Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269757AbUH0A7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269757AbUH0A7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269832AbUH0A43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:56:29 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:8112 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269789AbUHZXxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:53:23 -0400
Message-ID: <412E77F3.1090206@namesys.com>
Date: Thu, 26 Aug 2004 16:53:23 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Christophe Saout <christophe@saout.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net> <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com> <20040826112818.GL5618@nocona.random>
In-Reply-To: <20040826112818.GL5618@nocona.random>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Thu, Aug 26, 2004 at 01:35:01AM -0700, Hans Reiser wrote:
>  
>
>>Reiser4 plugins are not for end users to download from amazon.com, they 
>>are for weekend hackers to send me a cool plugin for me to review, 
>>assign a plugin id to, and send to Linus in the next release.  Sometimes 
>>    
>>
>
>then what's the difference in having the plugin fixed in stone into
>reiserfs? That's my whole point. Get the patch from the weekend hacker,
>check it, send the patch to Linus to add the new feature to reiser4,
>just call it "feature" not plugin. 
>
Think of it as being like VFS, where you can plugin new filesystems.  
Only in this case, you can plugin new kinds of files, and everything you 
need to implement those new kinds of files (items, nodes, keys, 
processing before flushing to disk, etc.) also gets implemented as a 
plugin.  It is an Uber-VFS.

> The only single reason we
>use modules is to avoid wasting tons of ram by loading every possible
>device driver on earth,
>
I am not concerned about ram in this design, I want nifty new kinds of 
files easy crafted over a weekend by sysadmins working in Canada and 
Guatemala.  Software engineering cost is what matters to me ( I turned 
40, so I think different now....;-) )


