Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVCQWOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVCQWOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCQWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:14:05 -0500
Received: from mail.tmr.com ([216.238.38.203]:65029 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261259AbVCQWOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:14:01 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Memory Stick Changes in 2.6.11?
Date: Thu, 17 Mar 2005 17:19:49 -0500
Organization: TMR Associates, Inc
Message-ID: <d1cup0$une$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1111096928 31470 192.168.12.100 (17 Mar 2005 22:02:08 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was pulling some pictures out of memory sticks from a camera, and 
after I pulled tham I was removing the image files from the stick. One 
of the sticks mounted read-only. After a few attempts to explicitly use 
"rw" in the mount command and things like that, I booted back into 
2.6.10 and found the stick mounted rw.

I looked at the code, and I don't see anything obvious. Can someone 
point me to where the change is made?

OT: I think that if I explicitly use the rw option the mount should do 
what I ask or fail. This "I can't do what you want so I did something 
else" behaviour make scripts more complex.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
