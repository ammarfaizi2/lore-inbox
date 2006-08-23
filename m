Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWHWVGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWHWVGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWHWVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:06:20 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:31416
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S965053AbWHWVGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:06:20 -0400
Date: Wed, 23 Aug 2006 14:05:58 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060823210558.GA17606@gnuppy.monkey.org>
References: <20060811221054.GA32459@gnuppy.monkey.org> <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com> <20060814234423.GA31230@gnuppy.monkey.org> <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com> <20060818115934.GA29919@gnuppy.monkey.org> <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com> <20060822013722.GA628@gnuppy.monkey.org> <20060822232051.GA8991@gnuppy.monkey.org> <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com> <20060823202046.GA17267@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823202046.GA17267@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:20:46PM -0700, Bill Huey wrote:
> On Wed, Aug 23, 2006 at 10:14:27AM -0700, Robert Crocombe wrote:
...
> > End result is as with the previous patch: nothing to serial console,
> > and just the single line moaning about line 471 in blah blah blah.
... 
> It might be the case that I need to remove some of that stuff and then
> reupload the patch. I'm kind of guessing at the problem right now with
> your stack dumps and it looks like the changes are causing more problems
> than it is helping. Let me change that and upload something else to you
> today.

http://mmlinux.sourceforge.net/public/against-2.6.17-rt8-1.diff

I turned off the __WARN_ON() change. I should test that more thoroughly.
I also cleaned up things a bit.

I'm on irc.oftc.net as "bh" if you want somebody that's interactive. It
might help with things here.

bill

