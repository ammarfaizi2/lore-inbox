Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbTIGSOy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTIGSNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:13:50 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:49678
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263426AbTIGSNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:13:38 -0400
Message-ID: <3F5B7537.9090805@cyberone.com.au>
Date: Mon, 08 Sep 2003 04:13:11 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Andrew Morton <akpm@osdl.org>, jyau_kernel_dev@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>	 <1062878664.3754.12.camel@boobies.awol.org>	 <3F5ABD3A.7060709@cyberone.com.au>  <20030906231856.6282cd44.akpm@osdl.org> <1062954122.12822.3.camel@boobies.awol.org>
In-Reply-To: <1062954122.12822.3.camel@boobies.awol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:

>On Sun, 2003-09-07 at 02:18, Andrew Morton wrote:
>
>
>>We cannot just jam all this code into Linus's tree while crossing our
>>fingers and hoping that something will turn up to fix this problem. 
>>Because we don't know what causes it, nor whether we even _can_ fix it.
>>
>
>Actually, this would be my argument _for_ Nick's approach.  It is simple
>and we all understand it.
>

Unfortunately (or fortunately?) you can't really get from my patch to
Con's in small simple steps, its basically one or the other. I'd like
to see my patch get included in 2.6, but I'm yet to convince many others.
Con is further along that road, so my only possibility for wider testing
is to try free up mm kernels for possible use ;) (if Andrew will have
them of course). Getting Con's patch more testing wouldn't hurt
anyone though, of course.


