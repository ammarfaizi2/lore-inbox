Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137138AbREKN5R>; Fri, 11 May 2001 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137139AbREKN5I>; Fri, 11 May 2001 09:57:08 -0400
Received: from ns.suse.de ([213.95.15.193]:57611 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137138AbREKN4w>;
	Fri, 11 May 2001 09:56:52 -0400
Date: Fri, 11 May 2001 15:56:41 +0200
From: Andi Kleen <ak@suse.de>
To: Dan Mann <daniel_b_mann@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c590 vs. tulip
Message-ID: <20010511155641.A11827@gruyere.muc.suse.de>
In-Reply-To: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OE73aZbF27y4RbrxUrO000014d0@hotmail.com>; from daniel_b_mann@hotmail.com on Fri, May 11, 2001 at 09:27:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 09:27:29AM -0400, Dan Mann wrote:
> I was just wondering if anybody had an idea which nic card might be a better
> choice for me; I have a pci 3c590 and a pci smc that uses the tulip driver.
> I don't have the card number for the smc with me handy, however I know both
> cards were manufactured in 1995.  Is either card/driver a better choice for
> a mildly used file server (I am running 2.4.4 Linus)?

As of 2.4.4 newer 3c90x (I guess you mean that, 3c59x should be mostly
extinct now) are a better choice because they support zero copy TX and 
hardware checksumming while tulip does not.

> faster machine it is much slower.  Images take at least .5 to 1 second to
> load when they are stored locally.  But over the network, with 2.4.4 and
> samba 2.2, It's as if the server "knows" what I'm going to ask for before I
> actually do.  Is this normal?  I honestly don't think it was this fast when
> server was on 2.2 Kernel with samba 2.07.

Sounds like a serious bug. Consider reporting it.

-Andi
