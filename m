Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266203AbUBCXVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUBCXVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:21:18 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:27829 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266203AbUBCXVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:21:14 -0500
Message-ID: <40202D17.1000904@namesys.com>
Date: Tue, 03 Feb 2004 15:21:59 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Vladimir Saveliev <vs@namesys.com>, linux-kernel@vger.kernel.org
Subject: ReiserFS V4 (was Re: 2.6.2-rc3-mm1)
References: <20040202235817.5c3feaf3.akpm@osdl.org>	<1075798370.1829.80.camel@tribesman.namesys.com> <20040203010456.3f3a2618.akpm@osdl.org>
In-Reply-To: <20040203010456.3f3a2618.akpm@osdl.org>
X-Enigmail-Version: 0.82.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>Be aware that the barriers for a new filesystem are relatively high: each
>one adds a significant maintenance burden to the VFS and MM developers.  It
>will need cautious review.
>  
>
Andrew, while it is your decision to make, it would be very silly to not 
let us upgrade ReiserFS.   V4 is 2-5x the speed of V3, has more 
functionality, better security, is more maintainable, etc.  Once V4 is 
as stable and tested as V3, no one in their right mind will use V3 on a 
new install.  While we will be happy to read improvements and critiques 
of our implementations from a clever coder such as yourself, we aren't 
exactly new to the Linux Kernel, and we are one of the very few in that 
community who have a real QA process that we systematically apply.  That 
is why we did not send it in many months ago: our testing is quite 
extensive, and we don't think users should find bugs that we can find if 
we make the effort.  Now we are running out of bugs that we can hit.  
There are distros that would like to ship using Reiser4 in April.


>But that doesn't mean we cannot get it out there, get you some more testing
>and exposure.  
>-
>
>  
>
Thanks,

Hans

