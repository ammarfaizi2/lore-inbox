Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272492AbRH3Vp5>; Thu, 30 Aug 2001 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272493AbRH3Vpr>; Thu, 30 Aug 2001 17:45:47 -0400
Received: from ns2.cypress.com ([157.95.67.5]:28324 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S272492AbRH3Vpi>;
	Thu, 30 Aug 2001 17:45:38 -0400
Message-ID: <3B8EB400.8020700@cypress.com>
Date: Thu, 30 Aug 2001 16:45:36 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.3.95.1010830171614.18406A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> that you can run, which shows that some versions of gcc don't even
> perform macro-expansion correctly.
> This version was shipped with RedHat 7.x
> 
> As you can see, the casts are !!!IGNORED!!! in gcc 2.96.

If you use cpp, you see that it is expanded.
But it still warns about it, which it shouldn't.
$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)

File a bug.

	-Thomas

