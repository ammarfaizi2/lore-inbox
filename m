Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUBBM4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUBBM4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:56:23 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:30341 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265613AbUBBM4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:56:22 -0500
Date: Mon, 2 Feb 2004 13:56:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202125640.GA1638@ucw.cz>
References: <UTC200402021244.i12Cien08901.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200402021244.i12Cien08901.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 01:44:40PM +0100, Andries.Brouwer@cwi.nl wrote:

> > all reasonable kernels support the ioctls
> 
> Just checked. KDKBDREP support was added in 2.4.9. Still a bit recent.

Ok.

> > when you're in X, and root, the ioctls will fail but /dev/port will still work
> 
> Yes, I think I'll check that stdin is a console, and otherwise do the /dev/port
> stuff only when a --portio option was given. I try to avoid testing kernel
> version values.

That's even better, yes.

> > EVIOCSKEYCODE
> 
> Will look at that.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
