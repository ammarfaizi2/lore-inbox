Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUBIBXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUBIBXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:23:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:2281 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264574AbUBIBXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:23:13 -0500
Date: Mon, 9 Feb 2004 02:23:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040209012311.GA18896@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz> <200402090113.23609.ctpm@rnl.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402090113.23609.ctpm@rnl.ist.utl.pt>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 01:13:23AM +0000, Claudio Martins wrote:
> 
>   Just FYI:
> 
>   CC      drivers/input/serio/i8042.o
> drivers/input/serio/i8042.c: In function `i8042_interrupt':
> drivers/input/serio/i8042.c:378: warning: `data' might be used uninitialized 
> in this function

It can't be used uninitalized. I've fixed this in my tree already, just
ignore the warning for the time being.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
