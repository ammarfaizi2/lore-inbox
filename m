Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUALIg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 03:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266082AbUALIg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 03:36:59 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:10123 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266081AbUALIg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 03:36:58 -0500
Date: Mon, 12 Jan 2004 09:36:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040112083647.GB2372@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br> <20040111235025.GA832@ucw.cz> <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401120004110.601@pervalidus.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 12:17:03AM -0200, Frédéric L. W. Meunier wrote:

> Vojtech, he reported the same problem I have. The "/ ?" key not
> working anymore with ABNT2 keyboards.
> 
> I tested with the patch and it didn't fix it on the console.

Yes, the patch didn't fix it for the console.

> I'm using kbd 1.10.
> 
> showkey under 2.4:
> 
> keycode  89

This, however, is VERY interesting, I didn't expect this keycode under
2.4 at all. Can you check with 'evtest' what it does send there?

> showkey under 2.6.1:
> 
> keycode   0 press
> keycode   1 release
> keycode  53 release
> keycode   0 release
> keycode   1 release
> keycode  53 release
> 
> It works with XFree86.
> 
> Since 2.6.0 worked, I assume something broke it.

Can you check what it does under 2.6.0? Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
