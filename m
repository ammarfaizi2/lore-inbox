Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282999AbRLRGjx>; Tue, 18 Dec 2001 01:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285632AbRLRGjn>; Tue, 18 Dec 2001 01:39:43 -0500
Received: from altus.drgw.net ([209.234.73.40]:1542 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S285631AbRLRGjb>;
	Tue, 18 Dec 2001 01:39:31 -0500
Date: Tue, 18 Dec 2001 00:39:28 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Domian Validation (Re: 2.5.1 - intermediate bio stuff..)
Message-ID: <20011218003927.D25200@altus.drgw.net>
In-Reply-To: <20011218000432.C25200@altus.drgw.net> <Pine.LNX.4.33.0112172210470.2416-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112172210470.2416-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 17, 2001 at 10:12:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 10:12:21PM -0800, Linus Torvalds wrote:
> 
> On Tue, 18 Dec 2001, Troy Benjegerdes wrote:
> >
> > Translation: Andre has been in a few too many ATA meetings and can't think
> > without using storage industry insider-speak ;)
> 
> We know ;)
> 
> > I only had a 6 months internship in storage, but I believe what he's
> > talking about are sound engineering principles.
> 
> No. Sound software engineering principles is to design good interfaces,
> and make the low level code adhere to them.

Well, I may have mis-stated my intentions in the last email. What I want
to see is some mechanism and *code* to test these interfaces and verify
that the low (AND high) level code is actually adhering to the interface,
as well as attemp to isolate which side of an interface a failure has
occured on. I want fault isolation, and TESTING to make sure that any 
fault we have seen in the past can be detected with easy-to run code.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
