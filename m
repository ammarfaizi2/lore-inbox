Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTJ1B32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTJ1B32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:29:28 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:7559 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263807AbTJ1B31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:29:27 -0500
Date: Tue, 28 Oct 2003 02:29:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031028012921.GA3452@ucw.cz>
References: <20031028005525.GC2886@ucw.cz> <Pine.LNX.4.44.0310271721070.1600-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310271721070.1600-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 05:23:13PM -0800, Linus Torvalds wrote:
> 
> On Tue, 28 Oct 2003, Vojtech Pavlik wrote:
> > 
> > Thanks, this one is good.
> 
> Note that the final one that made it into the kernel was slightly 
> different, in that I worry about the fact that "psmouse_command" can 
> change the source array, so I didn't do the "static" part (I know, I know, 
> I looked up PSMOUSE_CMD_SETRATE and it has zero result bytes, but I 
> decided to keep the patch minimal).
> 
> I also did the test for not-set in the caller, rather than change the rate 
> setting itself. 

Fine with me, too. I'll be sending you a bunch of small fixes for
atkbd.c tomorrow, including one that's the 'bigger surgery' (it in
reality doesn't look that big) that's mentioned in Andries's last patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
