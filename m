Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSGLISs>; Fri, 12 Jul 2002 04:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSGLISr>; Fri, 12 Jul 2002 04:18:47 -0400
Received: from are.twiddle.net ([64.81.246.98]:40324 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S314085AbSGLISq>;
	Fri, 12 Jul 2002 04:18:46 -0400
Date: Fri, 12 Jul 2002 01:21:23 -0700
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-cpu data...
Message-ID: <20020712012123.A21517@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20020712062058.25F21415D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712062058.25F21415D@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Jul 12, 2002 at 04:01:52PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 04:01:52PM +1000, Rusty Russell wrote:
> (__thread prepended to the decl, even
> though they had a perfectly good __attribute__ extension already).

Sorry, not our extension.  I just copied it.

> (From my reading, ## on "int x" and "__per_cpu" is well-defined).

Yep.

> Thoughts?

Seems ok, though you really ought to differentiate between
DECLARE and DEFINE.  Otherwise I can see getting screwed again.


r~
