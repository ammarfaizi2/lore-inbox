Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTHWGMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTHWGMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:12:33 -0400
Received: from smtp7.hy.skanova.net ([195.67.199.140]:25287 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262789AbTHWGMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:12:31 -0400
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random hangs in 2.6.0-test3-mm3
References: <20030821045444.GA465@eugeneteo.net>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Aug 2003 08:12:12 +0200
In-Reply-To: <20030821045444.GA465@eugeneteo.net>
Message-ID: <m2r83cykar.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Teo <eugene.teo@eugeneteo.net> writes:

> I am back. This time, I built a new box. It's an
> AMD XP 2400+ on ASUS A7N8X. I tried the same 2.6.0
> configuration as my Fujitsu E-7010 laptop, and again,
> I experienced random hangs. I have done memtest86
> on both, and there are no errors. I am very sure that
> my new box is working fine, same goes to my laptop.
> This time, I am unable to get any debugging messages,
> but will do so the next time I experience the same
> problem again.
...
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y

Note that early versions of the XFree86 synaptics driver had a bug
that could make the X server lock up. I'm not sure if this has
anything to do with your problem, but I have seen at least one lockup
report on the list that turned out to be caused by this bug.

The bug was fixed in version 0.11.3p5.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
