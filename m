Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268591AbRGYQmz>; Wed, 25 Jul 2001 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268592AbRGYQmf>; Wed, 25 Jul 2001 12:42:35 -0400
Received: from archive.osdlab.org ([65.201.151.11]:27309 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S268591AbRGYQmb>;
	Wed, 25 Jul 2001 12:42:31 -0400
Message-ID: <3B5EF66C.A90DAF6E@osdlab.org>
Date: Wed, 25 Jul 2001 09:40:12 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Julien Laganier <Julien.Laganier@Sun.COM>
CC: David CM Weber <dweber@backbonesecurity.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: device struct
In-Reply-To: <94FD5825A793194CBF039E6673E9AFE0C017@bbserver1.backbonesecurity.com> <3B5EF43E.C9EAF2B1@Sun.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Julien Laganier wrote:
> 
> David CM Weber wrote:
> >
> > I'm looking at some old (circa v2.2.5 of the kernel) sample code,
> > referring to the networking system. It refers to a structure named
> > "device".  Was this replaced with something else?
> >
> > On a similar note, is there a "good" way of finding this data myself?
> > I've been using ctags, and this is of limited use. (Sometimes good,
> > sometimes bad).
> >
> 
> Use CSCOPE, available at http://cscope.sourceforge.net
> It's very usefull !

I agree that cscope is useful, but the simple answer to David's
question is that struct device was replaced with struct net_device
in 2.4 so that the more generic struct device could be used for
more generic purposes.

~Randy
