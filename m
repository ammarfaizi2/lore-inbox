Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269330AbUI3QUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269330AbUI3QUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbUI3QUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:20:15 -0400
Received: from mail.tmr.com ([216.238.38.203]:54534 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269330AbUI3QSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:18:21 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: __attribute__((always_inline)) fiasco
Date: Thu, 30 Sep 2004 12:19:31 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhb65$5ka$1@gatekeeper.tmr.com>
References: <20040926012925.GA14305@thundrix.ch><20040926012925.GA14305@thundrix.ch> <20040926020556.GR9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096560646 5770 192.168.12.100 (30 Sep 2004 16:10:46 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20040926020556.GR9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
> 
>>>>#define INLINE static inline  // an oxymoron
>>>>#define INLINE extern inline  // an oxymoron
> 
> 
> On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
> 
>>>The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
>>>will cause spurious ignorance of the remainder of the line, which is
>>>often very important. e.g.
>>>static INLINE int lock_need_resched(spinlock_t *lock)
>>>{
>>>	...
> 
> 
> On Sun, Sep 26, 2004 at 03:29:25AM +0200, Tonnerre wrote:
> 
>>Mmm, shouldn't the comments be filtered *before* the definition is set
>>in place? Just wondering...
> 
> 
> I've already heard more about this than I ever cared to. I'll continue
> to stick to saner subsets of C and refuse to use things such as how the
> preprocessor committing incest with the compiler proper (no, I don't
> need it explained to me, it's trivial) allows crappy code to be written.
> Don't lecture me; there's nothing to explain and I don't want to hear it.

Don't hold back, tell us how you really feel ;-)

And I agree, those tricks shouldn't be used.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
