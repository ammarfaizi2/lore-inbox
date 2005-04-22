Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVDVQNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVDVQNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVDVQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 12:13:54 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:64898 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262053AbVDVQNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 12:13:52 -0400
Message-ID: <42692470.9050605@tmr.com>
Date: Fri, 22 Apr 2005 12:21:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mercurial v0.1 - a minimal scalable distributed SCM
References: <20050420101054.GE21897@waste.org>
In-Reply-To: <20050420101054.GE21897@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> http://selenic.com/mercurial/
> 
> April 19, 2005
> 
> I've spent the past couple weeks working on a completely new
> proof-of-concept SCM. The goals:
> 
>  - to initially be as simple (and thereby hackable) as possible
>  - to be as scalable as possible
>  - to be memory, disk, and bandwidth efficient
>  - to be able to do "clone/branch and pull/sync" style development

This sounds like an interesting tool, I want to look at it next week.
> 
> It's still very early on, but I think I'm doing surprisingly well. Now
> that I've got something that actually does some interesting things if
> you poke at it right, I figure it's time to throw it out there.

	[...]

> What remains to be done:
> 
>  - a halfway-usable command line tool
>  - remote (network) repository support
>  - diff generation
>  - changelog entry editing
>  - various manual interventions for merge
>  - handle rename
>  - handle rollback
>  - all sorts of other error handling
>  - all sorts of cleanup, packaging, documentation, testing...

The first one and the last one are really important... if a tool is hard 
to use, or poorly documented, people won't use it no matter how great it 
is. Or they will use it just long enough to create or find something better.

I admit that some of my own toys have never seen the light of day 
because I am unable to invest the time to handle those points.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
