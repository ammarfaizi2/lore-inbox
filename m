Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSGMNc5>; Sat, 13 Jul 2002 09:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGMNc4>; Sat, 13 Jul 2002 09:32:56 -0400
Received: from holomorphy.com ([66.224.33.161]:49569 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313181AbSGMNcy>;
	Sat, 13 Jul 2002 09:32:54 -0400
Date: Sat, 13 Jul 2002 06:34:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: compile the kernel with -Werror
Message-ID: <20020713133424.GF21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Muli Ben-Yehuda <mulix@actcom.co.il>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020713102615.H739@alhambra.actcom.co.il> <1026570243.9958.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1026570243.9958.81.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 08:26, Muli Ben-Yehuda wrote:
>> A full kernel compilation, especially when using the -j switch to
>> make, can cause warnings to "fly off the screen" without the user
>> noticing them.

On Sat, Jul 13, 2002 at 03:24:03PM +0100, Alan Cox wrote:
> May I suggest the user learns to use the command line properly. Adding
> -Werror doesn't help because gcc emits far too many bogus warnings for
> that.

This is not my favorite motive for -Werror. I prefer the "force people
to write cleaner code" aspect of it, but gcc's warnings are evil...


Cheers,
Bill
