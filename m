Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUKGJC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUKGJC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 04:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUKGJC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 04:02:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8196 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261560AbUKGJCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 04:02:24 -0500
Date: Sun, 7 Nov 2004 10:02:14 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console 80x50 SVGA
Message-ID: <20041107090213.GA8038@alpha.home.local>
References: <20041105224206.GA16741@leamonde.no-ip.org> <20041106073901.GA783@alpha.home.local> <20041106184112.GC16891@leamonde.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106184112.GC16891@leamonde.no-ip.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:41:12PM -0600, Camilo A. Reyes wrote:
> 
> If I may ask what vga number are you using to set it to 1024x768.
> I believe I have tried it before with no success, but I'm willing
> to try again.

I'm not right now in front of this one, but from memory, I believe I
set "vga=771" in lilo, and 773 should be 1280x1024. That's easy, you
take the mode you want from the documentation (Documentation/fb/vesafb.txt
I believe), you add 0x200 (512) to it and you use this value. So in my
case, 771 = 0x303 = 0x200 + 0x103, which should be the mode for 1024x768x8.

Hope this helps,
Willy

