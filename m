Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275269AbTHASfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275270AbTHASfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:35:40 -0400
Received: from auto-matic.ca ([216.209.85.42]:46085 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S275269AbTHASfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:35:37 -0400
Date: Fri, 1 Aug 2003 14:34:50 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Stephen Anthony <stephena@cs.mun.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: What's the timeslice size for kernel 2.6.0-test2, IA32?
Message-ID: <20030801183450.GC20001@mark.mielke.cc>
References: <200308011404.46886.stephena@cs.mun.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308011404.46886.stephena@cs.mun.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 02:04:46PM -0230, Stephen Anthony wrote:
> It would be great if sleeps were 1ms accurate instead of 10ms.  It would 
> make synchronization code a lot easier.

Doesn't this depend on what HZ you define for the kernel?

If you want 1ms sleep, just set HZ to 1000HZ+, and give your process a
high priority?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

