Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313084AbSDGKwX>; Sun, 7 Apr 2002 06:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSDGKwW>; Sun, 7 Apr 2002 06:52:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27143 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313084AbSDGKwV>; Sun, 7 Apr 2002 06:52:21 -0400
Date: Sun, 7 Apr 2002 11:52:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Radez <rob@osinvestor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WatchDog Driver Updates
Message-ID: <20020407115212.B30048@flint.arm.linux.org.uk>
In-Reply-To: <20020407083207.A28922@flint.arm.linux.org.uk> <Pine.LNX.4.33.0204070624470.3791-100000@pita.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 06:35:55AM -0400, Rob Radez wrote:
> Hmm...I'm not seeing any standards here.  Some drivers would just send
> whether the watchdog device was open, some would only send 0, sc1200
> would send whether the device was enabled or disabled, one did 'int one=1'
> and then a few lines later copy_to_user'd 'one', and it looks like all of
> three of twenty would actually return proper WDIOF flags.

Maybe Alan would like to comment and clear up this issue - I believe the
interface was Alan's design.  Certainly Alan wrote most of the early
watchdog drivers.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

