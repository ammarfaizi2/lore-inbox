Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVCCT4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVCCT4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCCTxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:53:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12709 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261961AbVCCTss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:48:48 -0500
Message-ID: <42276A0C.9080505@pobox.com>
Date: Thu, 03 Mar 2005 14:48:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <20050303191840.GA12916@kroah.com>
In-Reply-To: <20050303191840.GA12916@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

Two procedural suggestions...


> Ok, I've fixed up the patch and applied it to a local tree that I've set
> up to catch these things (it will live at
> bk://kernel.bkbits.net:gregkh/linux-2.6.11.y until Chris Wright and I
> set up how we are going to handle all of this.)

My suggestion would be one of two alternatives:

1) At each release, Linus clones
	linux.bkbits.net/linux-2.6
		to
	linux.bkbits.net/linux-2.6.11

and gives the "release team" access to push to linux-2.6.11 repo.


2) Create linux-release.bkbits.net, and some non-Linus person clones 
linux-2.6 at release time to linux-2.6.11.


This accomplishes two [minor] goals:
a) the tree lives at bkbits.net, as has a name associated with the goal 
of the project

b) The repo has the _exact_ name of the kernel release.  None of this 
"linux-2.6.11.y" stuff.  Just "linux-2.6.11".  Anything else violates 
the Principle of Least Surprise.


> Feel free to start pointing stuff like this at me and chris (we'll also
> be setting up an alias for it.)

I was wondering if it would be possible to setup a list on vger that is 
public, but read-only to everyone but the $sucker team.

	Jeff


