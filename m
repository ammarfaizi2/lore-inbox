Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263489AbUJ3Dxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbUJ3Dxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbUJ3Dxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:53:39 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:18567 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263489AbUJ3Dxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:53:32 -0400
Date: Sat, 30 Oct 2004 13:52:31 +1000
From: CaT <cat@zip.com.au>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: ext3 error with 2.6.9-rc4
Message-ID: <20041030035231.GB1287@zip.com.au>
References: <20041012142943.GD920@zip.com.au> <1097772670.2120.57.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097772670.2120.57.camel@sisko.scot.redhat.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 05:51:10PM +0100, Stephen C. Tweedie wrote:
> > Oct 13 00:17:03 nessie kernel: EXT3-fs error (device hdh1): ext3_readdir: bad entry in directory #3522561: rec_len is smaller than minimal - offset=4084, inode=3523431, rec_len=0, name_len=0
> 
> All this really tells us is that there's something bogus on disk, not
> how it got there.  
> 
> There are tools like "dt" which may help identify whether there's data
> going bad on the way to disk, or whether it might be a fs fault.
> 
> http://www.bit-net.com/~rmiller/dt.html

Thanks for that. A new utlitity to learn. :) Anyways, after getting my
laptop (and hence my access to email) back after a week I did a fair bit
of testing and the only way I can duplicate the above is by copying from
one hd to another. Further testing has led me to believe that the ext3
error is more of a symptom of data corruption caused in the IDE layer
somewhere rather then anything else.

I've posted a bug wrt to what I've discovered in the ide update thread
(my message before this one).

-- 
    Red herrings strewn hither and yon.
