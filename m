Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSGIRi7>; Tue, 9 Jul 2002 13:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSGIRi6>; Tue, 9 Jul 2002 13:38:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:64173 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313113AbSGIRi5>;
	Tue, 9 Jul 2002 13:38:57 -0400
Message-ID: <3D2B202D.6060602@us.ibm.com>
Date: Tue, 09 Jul 2002 10:41:01 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dan carpenter <error27@email.com>
CC: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: lock_kernel check...
References: <20020709172723.18529.qmail@email.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan carpenter wrote:
 > Smatch.pm is from the smatch.sf.net scripts page.  Smatch is a
 > really unfinished code checker that I've been working on.  It is
 > based on reading the papers about the Stanford checker.

There was a time when I was thinking about the same thing.  It kept 
scaring me the more I thought about it.

 > Unfortunately, after a night of sleep I realize that my script is
 > broken for 2 reasons. 1)  Smatch.pm is meant to track state changes
 > down different code paths.  But unfortunately it wasn't doing that
 > in this case; it was just going down the code without taking into
 > consideration any if_stmts  etc.  I'm extremely embarassed about
 > that.  Sorry.

Don't be sorry.  The script is smarter than the people who caused the 
errors.  (once again, probably me)

 > 2)  What the Stanford checker does is print an error
 > if one return_stmt is called while the kernel is locked and one is
 > called while the kernel is unlocked.  This seems reasonable.

Could you clarify that a bit?

 > I will fix both mistakes later on this week.  Unfortunately I'm in
 > the process of moving and looking for a job etc so I might not get
 > to it for a bit.


-- 
Dave Hansen
haveblue@us.ibm.com

