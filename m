Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVCUDMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVCUDMi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVCUDMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:12:38 -0500
Received: from relay03.pair.com ([209.68.5.17]:17168 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261511AbVCUDMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:12:33 -0500
X-pair-Authenticated: 24.126.76.52
Message-ID: <423E2E70.1010303@kegel.com>
Date: Sun, 20 Mar 2005 18:16:16 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: 2.6.11.3 build problem in arch/alpha/kernel/srcons.c with gcc-4.0
References: <423E238F.3030805@kegel.com> <20050320190352.65cc1396.akpm@osdl.org>
In-Reply-To: <20050320190352.65cc1396.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dan Kegel <dank@kegel.com> wrote:
> 
>>Anyone with an alpha care to suggest a fix for this?
>>
>>arch/alpha/kernel/srmcons.c: In function 'srmcons_open':
>>arch/alpha/kernel/srmcons.c:196: warning: 'srmconsp' may be used uninitialized in this function
>>make[1]: *** [arch/alpha/kernel/srmcons.o] Error 1
>>make: *** [arch/alpha/kernel] Error 2
>>
>>I get this when building the 2.6.11.3 kernel with a recent gcc-4.0 snapshot.
>>
> 
> 
> It's beyond gcc's ability to figure out that the code is OK.  Options would
> be to disable -Werror, or to artificially initialise that variable.

I'll initialize it to something - guess it doesn't matter what.

Thanks,
Dan


-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
