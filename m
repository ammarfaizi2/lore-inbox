Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVAZQ65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVAZQ65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVAZQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:53:07 -0500
Received: from the.earth.li ([193.201.200.66]:55181 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S262351AbVAZQrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:47:37 -0500
Date: Wed, 26 Jan 2005 16:47:33 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: e3-hacking@earth.li
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone.
Message-ID: <20050126164733.GT1405@earth.li>
References: <alan@lxorguk.ukuu.org.uk> <1096640407.21940.33.camel@localhost.localdomain> <200410011559.i91FxfH13266@blake.inputplus.co.uk> <35fb2e5904100109246f43ee7b@mail.gmail.com> <1096646380.21962.64.camel@localhost.localdomain> <20050107214852.GI5449@earth.li> <20050115134310.GS1725@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050115134310.GS1725@earth.li>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 01:43:10PM +0000, Jonathan McDowell wrote:
> On Fri, Jan 07, 2005 at 09:48:52PM +0000, Jonathan McDowell wrote:
> > On Fri, Oct 01, 2004 at 04:59:44PM +0100, Alan Cox wrote:
> > > If anyone has a copy of the emailer source btw (or gets one for review
> > > so has a download option ;)) then it would be nice to stick it up for
> > > ftp for all.
> > No one seems to have done this, and the offer Amstrad makes requires the
> > sending off of £25 to them to cover admin and distribution costs rather
> > than allowing a download of it. I did this a few days ago so will
> > hopefully hear from them in the next week or so.
> I've now received this.

Which turns out not to actually be what they're using; what I have
source for is "2.4.18_mvl30-E3" whereas my E3 has
"2.4.18_mvl30-ams-delta". Also there's no sign of a dfdblk/MFS-DFD
driver in the provided source, but the dmesg output of the E3 clearly
shows such a driver initialising before any filesystem is mounted,
ruling out the possiblity of it being a module.

I contacted Amstrad about this over a week ago, but to date haven't had
a response.

J.

-- 
9 out of 10 men who tried Camels prefer women.
