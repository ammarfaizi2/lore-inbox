Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTCTIPG>; Thu, 20 Mar 2003 03:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbTCTIPG>; Thu, 20 Mar 2003 03:15:06 -0500
Received: from angband.namesys.com ([212.16.7.85]:25475 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261313AbTCTIPF>; Thu, 20 Mar 2003 03:15:05 -0500
Date: Thu, 20 Mar 2003 11:25:59 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs oops [2.5.65]
Message-ID: <20030320112559.A12732@namesys.com>
References: <20030319141048.GA19361@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319141048.GA19361@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Mar 19, 2003 at 02:10:48PM +0000, Dave Jones wrote:
> Happened during this mornings cron jobs.
> find(1) had hung, taking the whole box with it.
> Could switch tty's, but no keyboard input at all,
> couldn't ssh into box..
> 12 hours previous, I had been putting it through a fairly
> heavy set of stresstests with ltp/fsx/fsstress, though
> nothing turned up then. I left the box idle, and went to
> bed, and woke up to find this...

Hm, very interesting. Thank you.
I've seen this once too, but on kernel patched with lots of unrelated and
possibly memory corrupting stuff.
I will look at it more closely.
BTW, it oopsed not in find. Is your box SMP?

Bye,
    Oleg
