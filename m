Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbTCGHEZ>; Fri, 7 Mar 2003 02:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbTCGHEY>; Fri, 7 Mar 2003 02:04:24 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:5072 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261400AbTCGHET>; Fri, 7 Mar 2003 02:04:19 -0500
Message-ID: <3E684737.7080704@kegel.com>
Date: Thu, 06 Mar 2003 23:16:07 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current hubub was caused by a build breakage, right?
And that build breakage was caused by a spellfix
outside of a comment.

Simple rules to avoid that problem:
1. don't fix anything not in a comment.  (spell-fix.pl doesn't.)
2. build after you fix
3. don't fix any comments in code you can't build
4. don't fix any punctuation at all

The earlier hubub was caused by people worried about
improper fixes (removing puns, changing meaning, etc.)
The simple expedient of having several literate people
(sensitized to all the concerns raised in this thread)
review the change should get rid of most of that risk.

So I don't think the spelling police have to beat a
total retreat.  They just have to follow the above
rules of thumb.

Or is the hubub really about something else?  Like people
just hate the whole idea, and wish it would go away,
and don't really want to discuss it rationally?
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

