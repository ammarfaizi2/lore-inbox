Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSETX2O>; Mon, 20 May 2002 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316439AbSETX2N>; Mon, 20 May 2002 19:28:13 -0400
Received: from holomorphy.com ([66.224.33.161]:11913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316437AbSETX2M>;
	Mon, 20 May 2002 19:28:12 -0400
Date: Mon, 20 May 2002 16:28:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Todd R. Eigenschink" <todd@tekinteractive.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Message-ID: <20020520232807.GE2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Todd R. Eigenschink" <todd@tekinteractive.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205160528.g4G5S631019167@sol.mixi.net> <15587.42492.25950.446607@rtfm.ofc.tekinteractive.com> <15592.62193.715212.569689@rtfm.ofc.tekinteractive.com> <20020520170059.GA2046@holomorphy.com> <15593.23568.756199.612888@rtfm.ofc.tekinteractive.com> <20020520223613.GD2046@holomorphy.com> <15593.33184.251533.467574@rtfm.ofc.tekinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 06:07:12PM -0500, Todd R. Eigenschink wrote:
> For whatever this may be worth--probably nothing--I have softdog
> compiled in, but it has only successfully rebooted after an oops maybe
> twice out of 20 or more oopsen.  On a bunch of them, the message has
> come out to the serial console that it was initiating a reboot (but it
> didn't).  Most of the time, it's just the oops and then...darkness.

Actually, getting  a notion of your sourcebase and what's actually
running sounds like a great idea. Any chance you could rattle off what
patches you've got and/or name the tree, and maybe send me a .config?
Also, any chance you could tell me a little about the hardware?
I'm not going to tell you what to run or not to run, I just want to
know where to start looking.


On Mon, May 20, 2002 at 06:07:12PM -0500, Todd R. Eigenschink wrote:
> Also, on the off chance that this is a code generation problem, this
> is gcc 2.95.3.  I actually was about to say 3.0.4 and wait for the
> slaps-upside-the-head, but I just checked and realized I haven't
> upgraded this box.

I don't know of any particular issues with gcc 2.95.3, but I'll compare
the disassemblies you sent me just in case.

Your help in tracking this down has been immense, I hope you have the
patience to bear with me as I try to fix this for you.


Thanks,
Bill
