Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUBOPf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUBOPf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:35:28 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:11648 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265117AbUBOPfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:35:23 -0500
Date: Sun, 15 Feb 2004 16:35:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re: keyboard and mouse driver module and...
Message-ID: <20040215153557.GA326@ucw.cz>
References: <Sea2-F45ritY7qJSGBJ0001683e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F45ritY7qJSGBJ0001683e@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 02:30:30PM +0200, sting sting wrote:
> Hello;
> Thnxs.
> If I understand right, then in 2.6 , after starting X windows when typing 
> lsmod,
> we should see both keyboard.o and mousedev.o .
> I just want to make sure that I understand you correctly.

No. keyboard is always built in, never a module. And regarding mousedev,
yes, you need that one. But X won't load it for you most likely.

And its .ko, not .o.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
