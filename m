Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267924AbUHZInL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUHZInL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUHZIj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:39:58 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:7600 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267866AbUHZIfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:35:01 -0400
Message-ID: <412DA0B5.3030301@namesys.com>
Date: Thu, 26 Aug 2004 01:35:01 -0700
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
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net> <20040825225933.GD5618@nocona.random>
In-Reply-To: <20040825225933.GD5618@nocona.random>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Wed, Aug 25, 2004 at 11:00:00PM +0200, Christophe Saout wrote:
>  
>
>>It should be completely forbidden to link into a meta-directory or out
>>of such a directory. [..]
>>    
>>
>
>agreed.
>
>  
>
>>Yes, I don't think it was a good idea either. Probably someone should
>>    
>>
>
>I personally would like plugins only if the API they use wouldn't allow
>them to corrupt the underlying fs, I'm not sure if this is the case with
>reiserfs4.
>  
>
You compile crap into the kernel, you are screwed.  We have not and will 
not change that.

Reiser4 plugins are not for end users to download from amazon.com, they 
are for weekend hackers to send me a cool plugin for me to review, 
assign a plugin id to, and send to Linus in the next release.  Sometimes 
being less ambitious works better, and dynamically loaded plugins would 
have made the infrastructure too bulky to be fun and fast.

