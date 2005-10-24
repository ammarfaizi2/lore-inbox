Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVJXSLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVJXSLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJXSLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:11:39 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:50370 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751224AbVJXSLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:11:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=bXLPWLaeN5pZmHHHZOF2i+TEBGRwmIM2oaBQgTnCvTgf2n6/pbjDLw5AcdYUOgJ7BJ1hN0s0CobCweIdUIJ3IndT1LBdR9arUGQ1dm+/Lf+ZgLLo9gUUXMdGHC3R6wIhJaQsT+7i2TZEPFZK5mw83t6XWqWqR04o1/hlGQfEorQ=
Subject: Re: [PATCH] RCU torture-testing kernel module
From: Badari Pulavarty <pbadari@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: paulmck@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ioe-lkml@rameria.de>, lkml <linux-kernel@vger.kernel.org>,
       arjan@infradead.org, pavel@ucw.cz, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ib.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
In-Reply-To: <5D5AD6EA-5D6E-47DA-8170-0729F9C32889@mac.com>
References: <20051022231214.GA5847@us.ibm.com>
	 <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com>
	 <200510232055.17782.ioe-lkml@rameria.de>
	 <20051023120521.26031051.akpm@osdl.org> <20051024004709.GA9454@us.ibm.com>
	 <1130171073.6831.6.camel@localhost.localdomain>
	 <5D5AD6EA-5D6E-47DA-8170-0729F9C32889@mac.com>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 11:10:58 -0700
Message-Id: <1130177458.6831.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 13:59 -0400, Kyle Moffett wrote:
> On Oct 24, 2005, at 12:24:33, Badari Pulavarty wrote:
> > Paul,
> >
> > I enabled RCU_TORTURE_TEST in 2.6.14-rc5-mm1. My machine took 10+  
> > minutes to boot and let me login. RCU kthreads are hogging the  
> > CPU.  Is this expected ?
> 
> Uhh...  It's a torture test.  What exactly do _you_ expect it will  
> do?  I think the idea is to enable it as a module and load it when  
> you want to start torture testing, and unload it when done.   
> "TORTURE_TEST"s are not for production systems :-D.

I was expecting that - even if its compiled in, there would be
a way to turn on/off the tests from /proc or something :)

Thanks,
Badari

