Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUI0U0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUI0U0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUI0U0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:26:32 -0400
Received: from av1-2-sn4.m-sp.skanova.net ([81.228.10.115]:7866 "EHLO
	av1-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S267341AbUI0UZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:25:50 -0400
To: James Oakley <joakley@solutioninc.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4 + alps locks input in X
References: <20040927192744.GA8947@luna.mooo.com>
	<200409271604.33993.joakley@solutioninc.com>
From: Peter Osterlund <petero2@telia.com>
Date: 27 Sep 2004 22:25:42 +0200
In-Reply-To: <200409271604.33993.joakley@solutioninc.com>
Message-ID: <m3wtyf792x.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Oakley <joakley@solutioninc.com> writes:

> On Monday 27 September 2004 4:27 pm, Micha Feigin wrote:
> > I tried both with mm4 with the already included alps patch and with
> > bk11 and bk13 with the patch manually applied. In both cases when
> > starting X with the alps driver input is completely dead in X, both
> > mouse and keyboard, including sysrq keys and num-lock/caps-lock.
> 
> I had this problem when I accidentally used the event device for my keyboard 
> instead of the touchpad. It didn't help that every alps XF86Config example 
> out there points to event1, which is my keyboard.
> 
> cat /proc/bus/input/devices to see which event device to use.

Or better yet, use the auto-dev feature, which should work if you have
a new enough X driver and kernel patch.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
