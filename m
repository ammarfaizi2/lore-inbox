Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUFJTAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUFJTAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUFJS64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:58:56 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29580 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262391AbUFJS5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:57:20 -0400
Message-ID: <40C8AF31.1010704@tmr.com>
Date: Thu, 10 Jun 2004 14:57:53 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <24vX0-81P-7@gated-at.bofh.it> <24WNz-4pO-3@gated-at.bofh.it>
In-Reply-To: <24WNz-4pO-3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> I would think that having an easy call to disable the NX modification would be both
> safe and effective.  That is, adding a syscall (or whatever) that would let you mark
> your heap and/or stack executable while leaving the new default as NX, is "just as
> safe" as flagging the executable in the first place.

It clearly wouldn't be safe, and that keeps it from being effective. 
Like having a great lock and burglar alarm, then putting the key and 
entry code under the mat. NX is to prevent abuse by BAD PEOPLE and 
therefore should not have any way to defeat it from within a program.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
