Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267948AbTBMBD5>; Wed, 12 Feb 2003 20:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267953AbTBMBD5>; Wed, 12 Feb 2003 20:03:57 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:2755 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267948AbTBMBD4>;
	Wed, 12 Feb 2003 20:03:56 -0500
Date: Thu, 13 Feb 2003 02:13:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] input: Get rid of kbd_pt_regs [5/14]
Message-ID: <20030213021333.A6256@ucw.cz>
References: <20030212120242.D1563@ucw.cz> <Pine.LNX.4.44.0302121611090.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0302121611090.31435-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Feb 12, 2003 at 04:13:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 04:13:51PM +0000, James Simmons wrote:

> One idea about kbd_pt_regs. Only one function, fn_show_ptregs, uses 
> kbd_pt_regs. Instaed of passing reg data around wouldn't be better to 
> just remove fn_show_ptregs from the FN_HANDLERS and call it independently 
> inside of kbd_keycode instead.

I'm not sure if that's really a nicer solution.

-- 
Vojtech Pavlik
SuSE Labs
