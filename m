Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUEZJ66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUEZJ66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUEZJ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:58:58 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:45671 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265399AbUEZJ65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:58:57 -0400
Message-ID: <40B46A57.4050209@yahoo.com.au>
Date: Wed, 26 May 2004 19:58:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: orders@nodivisions.com
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <40B4667B.5040303@nodivisions.com>
In-Reply-To: <40B4667B.5040303@nodivisions.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DiSante wrote:
> Nick Piggin wrote:
> 
>> The VM doesn't always get it right, and to make matters worse, desktop
>> users don't appreciate their long running jobs finishing earlier, but
>> *hate* having to wait a few seconds for a window to appear if it hasn't
>> been used for 24 hours.
> 
> 
> Come on, that is quite an exaggeration.  It can happen in a span of 
> minutes -- after rsyncing a dir to a backup dir, for example, which 
> fills ram rather quickly with cache I'll never use again.  Or after 
> configuring and compiling a package, which does the same thing.
> 

rsync is something known to break the VM's use-once heuristics.
I'm looking at that.

> As you said, the VM doesn't, in fact, always get it right.  If 512MB 
> worked before when it was half swap, 512MB of pure ram will work too, 
> only faster.  I don't see how adding more swap at that point could 
> increase performance unless you are keeping your ram full of non-cached 
> pages, and that's never the case for me -- my ram is almost always half 
> cached pages.
> 

It can.
