Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263001AbSJGMDs>; Mon, 7 Oct 2002 08:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263002AbSJGMDo>; Mon, 7 Oct 2002 08:03:44 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:22146 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263001AbSJGMDm>;
	Mon, 7 Oct 2002 08:03:42 -0400
Date: Mon, 7 Oct 2002 14:09:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X breaks PS/2 mouse
Message-ID: <20021007140916.A660@ucw.cz>
References: <20021004224547.A49400@ucw.cz> <200210042225.g94MPhJU012128@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210042225.g94MPhJU012128@darkstar.example.net>; from jbradford@dial.pipex.com on Fri, Oct 04, 2002 at 11:25:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 11:25:43PM +0100, jbradford@dial.pipex.com wrote:

> Pressing the left button, then the right button, (this is complete, and follows the above immediately):
> 
> i8042.c: 01 <- i8042 (interrupt, aux, 12) [230409]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [230410]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [230411]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [230548]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [230552]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [230554]
> i8042.c: 02 <- i8042 (interrupt, aux, 12) [231505]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [231506]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [231507]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [231694]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [231695]
> i8042.c: 00 <- i8042 (interrupt, aux, 12) [231696]
> 
> So, it definitely seems to be sending data to the port...  Strange...

It must work. I'm really wondering why it doesn't. What happens when you
load the 'evbug' module?

-- 
Vojtech Pavlik
SuSE Labs
