Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263543AbTJCOAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTJCOAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:00:55 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:51387 "EHLO
	natsmtp01.webmailer.de") by vger.kernel.org with ESMTP
	id S263543AbTJCOAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:00:53 -0400
Message-ID: <3F7D817A.7020603@softhome.net>
Date: Fri, 03 Oct 2003 16:02:34 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <aebr@win.tue.nl>
Subject: Re: [PATCH] linuxabi
References: <BCSP.62t.7@gated-at.bofh.it> <CcWl.7kh.9@gated-at.bofh.it> <CdIL.8ts.13@gated-at.bofh.it>
In-Reply-To: <CdIL.8ts.13@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> 
> Possibly. So we need discussion.
> 
> I have registered comment #1: Al prefers the enum style.
> A possibility.
> 
> Now you come with comment #2: write LINUX_MS_RDONLY instead of
> MS_RDONLY. You have not convinced me.
> 

   My 0.02 euro.

   LINUX_* - not right stuff. It makes a lot of sence to have the same 
name for same thing, even in different contexts. Or you are going to 
create a hell for some-one who may wish to make a documentation.

   Headers are going to be used in different context (hopefully) so 
would be no collisions (hopefully).

   Another question does GCC have something like C++'s namespace for C?
   That's would be good. Changing names - bad.

   And #define LINUX_NS(x) doesn't make sound - you will lose ability to 
grep over defines and [ce]tags will not work on this anymore. cpp is not
correct tool for namespace implementation.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

