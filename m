Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVATVe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVATVe6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVATVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:34:58 -0500
Received: from almesberger.net ([63.105.73.238]:4356 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262012AbVATVez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:34:55 -0500
Date: Thu, 20 Jan 2005 18:34:35 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH 0/29] overview
Message-ID: <20050120183435.C21510@almesberger.net>
References: <20050120102223.B14297@almesberger.net> <m1vf9s3ozr.fsf@ebiederm.dsl.xmission.com> <20050120165150.A21510@almesberger.net> <m1is5r502d.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1is5r502d.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Thu, Jan 20, 2005 at 01:15:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The hard one there is support of arbitrary OS's.

Bah, couldn't care less :-) If all else fails, you can fall back
to the "old-style" boot loader, and let this one boot the legacy
OS. (Well, for GRUB, you'd need the fallback extension, if this
isn't a standard feature yet.)

> Most people want to implement simple boot policies,
> and really don't care for the full complexity that some firmware
> solutions allow.  So what I have seen is people will take kexec
> and implement their custom policy instead of doing something complex.

I think many of them would just be as happy with a more complex
solution, as long as it comes in a nice bundle. Of course, if
there is no nice package to start from, they'll only implement
the bare minimum.

Also, in most cases, we can probably ignore space issues for now,
leave some room for experiments, and optimize later.

> The goal
> now is to build enough confidence so that we can move from the
> development to the stable kernel.

Yes, that's what I mean with it being in "mainline". For user
space to begin making use of kexec, it really should be part of
a kernel most people can accept for regular use.

> Want to help?

Trying to, by explaining why it should move on :-) Anything else
you need ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
