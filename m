Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUBVGHi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUBVGHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:07:38 -0500
Received: from relay.pair.com ([209.68.1.20]:58889 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261168AbUBVGHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:07:37 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <403845F5.5030101@kegel.com>
Date: Sat, 21 Feb 2004 22:02:29 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
       Judith Lebzelter <judith@osdl.org>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
References: <20040222035350.GB31813@MAIL.13thfloor.at>
In-Reply-To: <20040222035350.GB31813@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
>    the GCC testsuite contains 2854 files in the relevant 
>    subdirs consistency.vlad, gcc.c-torture, gcc.dg, and
>    gcc.misc-tests.
>     
>    after removing the non relevant tests (file matching 
>    egrep '#include|float|double') 1799 C files remain.
>      
>    the result of the tests and comparison[4] shows that
>    both compilers produce the same code, except for one
>    little difference[5], which I'm unable to explain ...  
 > [5]  http://vserver.13thfloor.at/Stuff/Cross/Comparison/TEST-alpha.diff
 > ...

>    my conclusion so far is that my approach should be
>    sufficient for Kernel Cross Compiling.

Perhaps, but it's harder to repeat than using my crosstool script;
you said you had to munge a bunch of header files, but with
crosstool no special munging is required.  AFAIR you haven't
posted your header-munging procedure.

It's vaguely possible that your header munging was wrong, which
caused that one diff on alpha.

Say, could you compare compiling the kernel with the two
toolchains, and see if there are any differences?
- Dan

-- 
US citizens: if you're considering voting for Bush, look at these first:
http://www.misleader.org/
http://www.cbc.ca/news/background/arar/
http://www.house.gov/reform/min/politicsandscience/
