Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUFKSGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUFKSGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 14:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFKSGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 14:06:34 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21942 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264295AbUFKSGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 14:06:24 -0400
Message-ID: <40C9F4DF.3020200@namesys.com>
Date: Fri, 11 Jun 2004 11:07:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Dave Jones <davej@redhat.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>	 <1086784264.10973.236.camel@watt.suse.com>	 <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>	 <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com>	 <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com>	 <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com>	 <20040611134621.GA3633@wohnheim.fh-wedel.de>  <40C9DE9F.90901@namesys.com> <1086976005.10973.364.camel@watt.suse.com>
In-Reply-To: <1086976005.10973.364.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Fri, 2004-06-11 at 12:32, Hans Reiser wrote:
>
>  
>
>>Reiser4 is going to obsolete V3 in a few weeks.  V3 will be retained for 
>>compatibility reasons only, as V4 blows it away in performance.
>>
>>    
>>
>
>This would be the conservative release management you were talking about
>before, right?  It's going to take a considerable amount of time for v4
>to obsolete v3, because it will take a considerable amount of time for
>v4 to become stable under the wide range of conditions that filesystems
>get used.
>  
>
A better statement would be:

V3 will exist for those who don't want to use the latest fs on the 
block, and for those who started to use V3 and don't care enough about 
performance and features to engage in the work needed to change (99% of 
existing users, unless someone funds convertfs).

>Please don't misunderstand this as a statement against v4, I would love
>to see it be 1000x as fast as every other FS.  I'm only asking for some
>kind of realism in the expectations you give the users.
>
>-chris
>
>
>
>
>  
>

