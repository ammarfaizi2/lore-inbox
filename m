Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSGXQqY>; Wed, 24 Jul 2002 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSGXQqY>; Wed, 24 Jul 2002 12:46:24 -0400
Received: from otter.mbay.net ([206.55.237.2]:39691 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S317400AbSGXQqX> convert rfc822-to-8bit;
	Wed, 24 Jul 2002 12:46:23 -0400
From: John Alvord <jalvo@mbay.net>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Martin Brulisauer <martin@uceb.org>, Joshua MacDonald <jmacd@namesys.com>,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Date: Wed, 24 Jul 2002 09:49:13 -0700
Message-ID: <t0mtjucnisk60j2656fupb8bd7vb9jjkst@4ax.com>
References: <3D3E75E9.28151.2A7FBB2@localhost> <3D3EA294.30758.3567B82@localhost> <20020724115850.GS11081@unthought.net>
In-Reply-To: <20020724115850.GS11081@unthought.net>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 13:58:50 +0200, Jakob Oestergaard
<jakob@unthought.net> wrote:

>On Wed, Jul 24, 2002 at 12:50:28PM +0200, Martin Brulisauer wrote:
>...
>> So it is.
>> 
>> At kernel level nothing will stop me to halt() the cpu, if I realy want 
>> to. It is important to understand that tools (and all compilers are
>> just tools) will not enable me to write correct code. 
>
>That is a lame argument.
......
>Macros are not a pretty solution, but it is as I see it the only way to
>achieve type safety in generic code.  If someone else out there has
>other suggestions, please let me know - I actually like to be proven
>wrong (because that means I learn something new).
>
>I'd take macro-hell in generic code over void* hell in every single
>list-using part of the kernel any day.

There was a similar flare-up about a year ago when type safety was
added to the min and max macros. The initial implementation was a bit
strange, but the final one used some gcc-ism and now no one complains.

john alvord

