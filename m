Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTIEGBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 02:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTIEGBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 02:01:50 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65156
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262258AbTIEGBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 02:01:49 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: Fix up power managment in 2.6
Date: Fri, 5 Sep 2003 01:58:36 -0400
User-Agent: KMail/1.5
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309011509450.5614-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0309011509450.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309050158.36447.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 September 2003 18:55, Patrick Mochel wrote:

> In all actuality, I don't need swsusp. I have a better suspend-to-disk
> implementation that is faster, smaller, and cleaner. I've hesitated
> merging it because I thought swsusp improvements would be more welcome.
> Obviously they're not; or you haven't actually taken the time to read the
> code.

Is there somewhere we can download your code?  swsusp in -test3 hung my box 
immediately without touching the disk, and in -test4 there doesn't seem to be 
any way to trigger it under /proc or /sys...

I've been subscribed to the swsusp list for two weeks now and 2.6 has only 
been mentioned _once_, and that was a two message thread with somebody asking 
about it and nigel saying he didn't have time to work on it right now.  It's 
a apparently a 2.4-only list, and I don't use 2.4 anymore.

APM suspend doesn't work properly on my new thinkpad (suspends but hangs with 
the power LED still on and the hibernate light off, and the thing's a brick 
at that point; the only thing you can do is hold the power button down for 
ten seconds or pop the battery to get it to boot back up from scratch.)  So I 
have to shut the sucker down every time I want to move it, which is a pain...

Rob
