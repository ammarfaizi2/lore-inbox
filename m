Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUHaCXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUHaCXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 22:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHaCXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 22:23:14 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:60834 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S266245AbUHaCXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 22:23:07 -0400
Message-ID: <4133E109.5040301@pobox.com>
Date: Mon, 30 Aug 2004 22:23:05 -0400
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Burnes, James" <james.burnes@gwl.com>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: reiser4 semantics / BeFS Architect(s) Query Resolution
References: <3DF9165145FACB4C96977FF650C1E9040C46A3D1@its-mail1.its.corp.gwl.com>
In-Reply-To: <3DF9165145FACB4C96977FF650C1E9040C46A3D1@its-mail1.its.corp.gwl.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burnes, James wrote:
> (comments below)
> 
> 
>>-----Original Message-----
>>From: Hans Reiser [mailto:reiser@namesys.com]
>>Sent: Saturday, August 28, 2004 3:55 AM
>>To: Will Dyson
>>Cc: Andrew Morton; hch@lst.de; linux-fsdevel@vger.kernel.org; linux-
>>kernel@vger.kernel.org; flx@namesys.com; torvalds@osdl.org; reiserfs-
>>list@namesys.com
>>Subject: Re: silent semantic changes with reiser4
>>
>>I think there are two ways to analyze the code boundary issue.  One is
>>"does it belong in the kernel?"  Another is, "does it belong in the
>>filesystem. and if so should name resolution in a filesystem be split
>>into two parts, one in kernel, and one in user space."  In ten years I
>>might have the knowledge needed to make such a split, but I know for
>>sure that I don't know how to do it today without regretting it
>>tomorrow, and I don't really have confidence that I will ever be able
>>to do it without losing performance.
>>
>>Glad that BeFS finds the new model better.:)
>>
> 
> (glad that BeFS supposedly solved it)

Solved what, exactly? I'm already having a hard time understanding what 
Hans is talking about.

> BTW: I get paid during the day to do security engineering work.
> Wouldn't parsing the query in the kernel make the kernel susceptible to
> buffer overflows?  Bad place to have an overflow.



-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman
