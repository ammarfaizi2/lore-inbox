Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbSJHAO5>; Mon, 7 Oct 2002 20:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbSJHAO5>; Mon, 7 Oct 2002 20:14:57 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:54023 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S262633AbSJHAOz>;
	Mon, 7 Oct 2002 20:14:55 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007220106.A1640@ucw.cz>
References: <20020926105853.A168142@ucw.cz>
	<1033039991.708.6.camel@chevrolet> <20020926133725.A8851@ucw.cz>
	<1033054211.587.6.camel@chevrolet> <20020926185717.B27676@ucw.cz>
	<1033080648.593.12.camel@chevrolet> <20020927091040.B1715@ucw.cz>
	<1033127503.589.6.camel@chevrolet> <20021007150052.A1380@ucw.cz>
	<1034020510.1499.8.camel@chevrolet>  <20021007220106.A1640@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Oct 2002 02:20:49 +0200
Message-Id: <1034036449.688.8.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 2002-10-07 kl. 22:01 skrev Vojtech Pavlik:
> On Mon, Oct 07, 2002 at 09:55:10PM +0200, Stian Jordet wrote:
[snip]
> > I was starting to think you had forgot me :)
> 
> In that case you should have reminded me of your problem. I tend to
> forget when e-mails accumulate beyond a couple hundreds. ;)

I kinda did, in a polite manner. Perhaps I was to polite :)

> > The patch helped a lot. Now it doesn't crash at all. But when I use
> > RIGHT-ALT+PAGE-UP, I get these errors a couple of times, then it
> > suddenly works as it should.
[snip}
> I still don't like this behavior - the keyboard shouldn't reinitialize.
> Can you repeat the same with I8042_DEBUG_IO?
> 
> I definitely wasn't able to reproduce this here with very violent
> bashing at my keyboard. And l/r alt-pageup works here just fine.

Ok, this is very weird. I tried many times that first boot, and it
wouldn't crash what so ever. Ok, it came up with some errors, but I
couldn't get it to crash. After a recompile with debug enabled,
everything went totally nuts. It didn't crash, but if I pressed S (or
what ever key) I would get a screen full of that. Everything was crazy.
But still no crash. I rebootet, still same behavior. Then I turned of
debugging, and compiled again. And this time it started crashing again
(!). I have no idea why, but now it's like it have always been. I have
tried several times, used a fresh kerneltree, and patched again, no
help. Freezes just like before. I will try some more tomorrow (I'm going
to university in five hours), but I really can't understand what have
happened. 

Thanks anyway for you work :)

Best regards,
Stian Jordet

