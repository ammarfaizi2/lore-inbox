Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266031AbUFIXni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUFIXni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUFIXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:43:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:10385 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266031AbUFIXn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:43:27 -0400
Message-ID: <40C7A0CA.7000202@namesys.com>
Date: Wed, 09 Jun 2004 16:44:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>	 <1086784264.10973.236.camel@watt.suse.com>	 <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>	 <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com> <1086806933.10973.299.camel@watt.suse.com>
In-Reply-To: <1086806933.10973.299.camel@watt.suse.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Wed, 2004-06-09 at 14:09, Hans Reiser wrote:
>
>  
>
>>Unless it is really necessary, or a small code change, I would prefer to 
>>spend our cycles worrying about this in reiser4, because code changes in 
>>V3 are to be avoided if possible.
>>
>>I am open to arguments that it is really necessary.
>>    
>>
>
>It's pretty important, especially when you toss NFS into the call path
>the stack usage can go higher.  The switch to kmalloc will be relatively
>small and by now we're good at testing for schedule bugs.
>
>-chris
>
>
>
>
>  
>
Performance impact of kmalloc?
