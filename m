Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265323AbUEZJmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbUEZJmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 05:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUEZJmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 05:42:23 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:16280 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S265323AbUEZJmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 05:42:21 -0400
Message-ID: <40B4667B.5040303@nodivisions.com>
Date: Wed, 26 May 2004 05:42:19 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au>
In-Reply-To: <40B4590A.1090006@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> The VM doesn't always get it right, and to make matters worse, desktop
> users don't appreciate their long running jobs finishing earlier, but
> *hate* having to wait a few seconds for a window to appear if it hasn't
> been used for 24 hours.

Come on, that is quite an exaggeration.  It can happen in a span of minutes 
-- after rsyncing a dir to a backup dir, for example, which fills ram rather 
quickly with cache I'll never use again.  Or after configuring and compiling 
a package, which does the same thing.

As you said, the VM doesn't, in fact, always get it right.  If 512MB worked 
before when it was half swap, 512MB of pure ram will work too, only faster. 
  I don't see how adding more swap at that point could increase performance 
unless you are keeping your ram full of non-cached pages, and that's never 
the case for me -- my ram is almost always half cached pages.

-Anthony
http://nodivisions.com/
