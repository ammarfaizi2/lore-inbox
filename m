Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUH1GRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUH1GRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUH1GR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:17:29 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:46989 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266910AbUH1GRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:17:12 -0400
Message-ID: <41302366.3020306@namesys.com>
Date: Fri, 27 Aug 2004 23:17:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Zarochentsev <zam@namesys.com>
CC: Andrea Arcangeli <andrea@suse.de>, Christophe Saout <christophe@saout.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net> <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com> <20040826112818.GL5618@nocona.random> <1093520699.9004.11.camel@leto.cs.pocnet.net> <20040826121630.GN5618@nocona.random> <20040827183858.GF5108@backtop.namesys.com>
In-Reply-To: <20040827183858.GF5108@backtop.namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:

>
>
>There should be infracture to change plugin on fly, and choosing object's
>plugins at object's creation time.  Currently only certain object's plugins
>can be changed through <object>/metas/plugin interface. 
>  
>
To be more clear for those not familiar with our project, there is much 
more work to be done, and one of the areas that (extremely) needs more 
work is changing plugins on the fly and clean interfaces for specifying 
them at creation time.
