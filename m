Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTAFS6N>; Mon, 6 Jan 2003 13:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTAFS6N>; Mon, 6 Jan 2003 13:58:13 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:31111 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S267097AbTAFS6M>; Mon, 6 Jan 2003 13:58:12 -0500
Date: Mon, 6 Jan 2003 12:06:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
Message-ID: <20030106190648.GD796@opus.bloom.county>
References: <20030106185025.GC796@opus.bloom.county> <Pine.LNX.4.33L2.0301061053130.15416-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301061053130.15416-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 10:57:01AM -0800, Randy.Dunlap wrote:
> On Mon, 6 Jan 2003, Tom Rini wrote:
> 
> | On Thu, Jan 02, 2003 at 03:09:17PM -0800, Randy.Dunlap wrote:
> |
> | > This patch to 2.5.54 make LOG_BUF_LEN a configurable option.
> | > Actually its shift value is configurable, and that keeps it
> | > a power of 2.
> |
> | Erm, why not just prompt for an int, slightly change the help wording,
> | and then just give a default int value directly.
> |
> | Flexibility is good for everyone.
> 
> Sure, I like that, but LOG_BUF_LEN must be a power of 2 (currently)
> and I was trying not to rewrite that circular buffer code, that's all.
> However, I will if that's desirable.

I actually meant prompting for the shift value itself.

> And kconfig doesn't have a way to enforce the selected value...

That is a shame, I've had to resort to doing checks like that at compile
time for that reason.

> Linus also told me that he's not crazy about this change.

Maybe he would be, if it was cleaner than the current code in the end.
:)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
