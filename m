Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbTJIXNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTJIXNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:13:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:46475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262611AbTJIXNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:13:14 -0400
Date: Thu, 9 Oct 2003 16:12:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: maximilian attems <janitor@sternwelten.at>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       rmk@arm.linux.org.uk
Subject: Re: [patch] add CC Trivial Patch Monkey to SubmittingPatches
Message-Id: <20031009161207.568b3ba6.rddunlap@osdl.org>
In-Reply-To: <20031009121656.GA14373@mail.sternwelten.at>
References: <20031009105228.GB1138@mail.sternwelten.at>
	<20031009122545.A16265@flint.arm.linux.org.uk>
	<20031009121656.GA14373@mail.sternwelten.at>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003 14:16:56 +0200 maximilian attems <janitor@sternwelten.at> wrote:

| > Could you take care when spelling names to ensure that you get them
| > correct *PLEASE*.  I for one are sick and tired of trying to get
                                 am  [at least in en_US]
| > people to spell my name correctly.  Personally, I see it as an insult
| > that people can't take the time to get it correct.
| 
| upps .. corrected!
| 
| as demonstrated by my signature,
| i do personally not care about the spelling
| of my own name so please don't take it as insult.
| the german writer of "ziegelbrenner" used to confuse 
| autority with his many different names..
| 
| a++
| ma(ks|x(imilian)?)
| 
| 
| --- linux-2.6.0-test7/Documentation/SubmittingPatches	2003-10-08 21:24:00.000000000 +0200
| +++ linux/Documentation/SubmittingPatches	2003-10-09 12:41:22.000000000 +0200
| @@ -132,6 +132,21 @@
|  Even if the maintainer did not respond in step #4, make sure to ALWAYS
|  copy the maintainer when you change their code.
|  
| +For small patches you may want to CC Trivial Patch Monkey 
| +trivial@rustcorp.com.au set up by Rusty Russell which collects "trivial" 
| +patches. Trivial patches must qualify for one of the following rules:
| + Spelling fixes in documentation
| + Spelling fixes which could break grep(1).
| + Warning fixes (cluttering with useless warnings is bad)
| + Compilation fixes (only if they are actually correct)
| + Runtime fixes (only if they actually fix things)
| + Removing use of deprecated functions/macros (eg. check_region).
| + Contact detail and documentation fixes
| + Non-portable code replaced by portable code (even in arch-specific, 
| + since people copy, as long as it's trivial)
| + Any fix by the author/maintainer of the file. (ie. patch monkey 
| + in re-transmission mode)
| +

Maybe add the Trivial Patch Monkey web page:
  http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/

--
~Randy
