Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVCCXC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVCCXC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCCXBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:01:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:58805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262662AbVCCWMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:12:32 -0500
Date: Thu, 3 Mar 2005 14:13:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Greg KH'" <greg@kroah.com>,
       "'David S. Miller'" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RE: RFD: Kernel release numbering
In-Reply-To: <200503032156.AWY71165@mira-sjc5-e.cisco.com>
Message-ID: <Pine.LNX.4.58.0503031410280.25732@ppc970.osdl.org>
References: <200503032156.AWY71165@mira-sjc5-e.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Hua Zhong wrote:
> 
> Indeed. What I have in mind (and suggested in the past) is that we have a
> real 2.6 stable release maintainer. The only difference is that he starts
> from a random 2.6.x release he picks, and releases 2.6.x.y until he thinks
> stable enough, and he moves on to another 2.6.z release and start the same
> work.

This is exactly how distributions work (or are at least supposed to). As 
such, it's not something _I_ care about, except in the sense of "yes, 
that's how you guys should do it". The reason I personally don't care any 
more is that it has the back- and forward-port issues, so somebody will 
have to do that, and it sure ain't me.

Now, if you are arguing that it should be something where different 
distributions do it together and don't waste engineers on their own tree, 
I do kind of agree. "Kind of", because I think different distributions 
have different issues (like timing), and that it may well just be too much 
work to try to synchronize them and keep everybody happy.

At some point it's easier and cheaper to just "waste energy". I see my job
as giving a base-line where somebody _can_ start doing the above, but at 
some point it's out of my hands.

		Linus
