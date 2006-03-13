Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWCMQQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWCMQQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWCMQQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:16:19 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:35631 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932154AbWCMQQT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:16:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UAKlU+n+kZPCON6yEmTj4hn+reqgU/DnplNibp1L1FB0dw6NCBK1rcjr1B22wrDJiFzmJ2UHBrUOfNk7EWTwZrt5vUhgrJlF16v5+OLA1ZKis1PtKMopNX8HnA1/dd+3z3Wh+sTr6uO5p2idzlkoRkwwUhodcjph9GkTQJzi37g=
Message-ID: <161717d50603130816u1d63caa1j432d00dd5c54e454@mail.gmail.com>
Date: Mon, 13 Mar 2006 11:16:18 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: davids@webmaster.com
Subject: Re: [future of drivers?] a proposal for binary drivers.
Cc: linux-kernel-owner+davids=40webmaster.com-S1750982AbWCLRJa@vger.kernel.org,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <WorldClient-F200603121819.AA19110002@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060311091623.GB4087@DervishD>
	 <MDEHLPKNGKAHNMBLJOLKGEHBKKAB.davids@webmaster.com>
	 <161717d50603120909w41413b00g6ad82af79b051fd3@mail.gmail.com>
	 <WorldClient-F200603121819.AA19110002@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/06, David Schwartz <davids@webmaster.com> wrote:
>
> The issue is not the complexity of the TLP, the issue is simply that you
> cannot use copyright to get protection that is capable of being expressed in
> functional terms. You cannot own every way to express a functional idea.
> That's what patents are for.

That is not what the court said, and the section I quoted you shows
that quite plainly.

In Static Controls, the issue was a 55 byte program to calculate the
level of toner in a cartridge. The court ruled that the program design
of the TLP was so constrained by external factors (the efficient
execution of a small number of calculations) that any other
implementation would have been impractical.

Linux is a completely different matter, directly analogous to Apple's
OS in the court's analysis. There are no such external factors
dictating the form of the kernel's facilities for integrating new
functionality. The kernel developers could have chosen some other
means for drivers to coordinate their activities with the kernel than
the current driver model (for instance, the means employed in Linux
2.4).

You keep insisting that "a driver for hardware X under Linux" is a
functional idea. It is not. "Calculate the amount of toner left" is a
functional idea. "Set the control register of hardware X to value Y"
is a functional idea (and not copyrightable due to scenes a faire).

I can understand how you might think, "well, nVidia could have chosen
some other means of representing pixels on the screen and controlling
them" is analagous to "well, the kernel developers could have chosen
some other means for modules or drivers to interact with the system,"
but graphics hardware is not copyrightable, software is. To conflate
the two as you seem to want to do would render pretty much all
software uncopyrightable. That might be preferable to you, but it
would crush innovation in software development and make it impossible
for anyone but largish businesses to create software.

Dave
