Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWCHCa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWCHCa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWCHCa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:30:29 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:31362 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932315AbWCHCa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:30:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] mm: yield during swap prefetching
Date: Wed, 8 Mar 2006 13:30:56 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
References: <200603081013.44678.kernel@kolivas.org> <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe>
In-Reply-To: <1141784834.767.134.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081330.56548.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006 01:27 pm, Lee Revell wrote:
> On Wed, 2006-03-08 at 13:22 +1100, Con Kolivas wrote:
> > > How is the scheduler supposed to know to penalize a kernel compile
> > > taking 100% CPU but not a game using 100% CPU?
> >
> > Because being a serious desktop operating system that we are
> > (bwahahahaha) means the user should not have special privileges to run
> > something as simple as a game. Games should not need special scheduling
> > classes. We can always use 'nice' for a compile though. Real time audio
> > is a completely different world to this.
>
> Actually recent distros like the upcoming Ubuntu Dapper support the new
> RLIMIT_NICE and RLIMIT_RTPRIO so this would Just Work without any
> special privileges (well, not root anyway - you'd have to put the user
> in the right group and add one line to /etc/security/limits.conf).
>
> I think OSX also uses special scheduling classes for stuff with RT
> constraints.
>
> The only barrier I see is that games aren't specifically written to take
> advantage of RT scheduling because historically it's only been available
> to root.

Well as I said in my previous reply, games should _not_ need special 
scheduling classes. They are not written in a real time smart way and they do 
not have any realtime constraints or requirements.

Cheers,
Con

