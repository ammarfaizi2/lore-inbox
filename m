Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUIGU1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUIGU1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUIGU04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:26:56 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:58533 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268641AbUIGUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:16:10 -0400
Message-ID: <413E170F.9000204@namesys.com>
Date: Tue, 07 Sep 2004 13:16:15 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, reiserfs-list@namesys.com
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea of what reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <20040831131201.GA1609@elf.ucw.cz>
In-Reply-To: <20040831131201.GA1609@elf.ucw.cz>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>Answer: choose obscure names
>>
>>Problem (all credit to Mr. Demidov for identifying this problem, I
>>argued the other viewpoint, and I can only claim the wisdom to know
>>that I lost the argument): names like "..metas" are ugly to new users,
>>who don't really care for languages that use punctuation in their
>>keywords.
>>
>>Answer
>>
>>don't make them too obscure, experienced namespace developers know
>>that the problem of polluting the namespace is not really as big a
>>deal as beginners think it is, and Clearcase and the WAFL filesystem
>>manage to get by just fine, whereas the problem of putting punctuation
>>marks into names and syntax is a big deal for newbies to the system.
>>Name it "metas" not "..metas", and users will never experience it as a
>>real problem, and newbies will never be annoyed by a-rhythmic
>>punctuation.  Note: if Linus disagrees, it is not the most important
>>thing in this design, "..metas" isn't the end of the world.
>>    
>>
>
>What about choosing just "..." instead of "metas"? "metas" is string
>that needs translation etc, while "..." is nicely neutral.
>
>cat /sound_of_silence.mp3/.../author
>
>does not look bad, either...
>								Pavel
>  
>
"..." is pretty good, but I think it has been used by others, but I 
really forget who.  I could live with "...", but I think "metas" and 
"..metas" will collide less often.  Apparently Meta is a finnish name or 
something, so Linus does not like it.  The exact string is really not 
very important to me.  I agree that "..." is elegant.

Hans
