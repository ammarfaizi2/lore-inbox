Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271257AbRHOQMR>; Wed, 15 Aug 2001 12:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271256AbRHOQMH>; Wed, 15 Aug 2001 12:12:07 -0400
Received: from shad0w.dial.nildram.co.uk ([195.112.18.51]:52746 "EHLO
	mail.shad0w.org.uk") by vger.kernel.org with ESMTP
	id <S271257AbRHOQL4> convert rfc822-to-8bit; Wed, 15 Aug 2001 12:11:56 -0400
Date: Wed, 15 Aug 2001 17:14:21 +0100 (BST)
From: Chris Crowther <chrisc@shad0w.org.uk>
To: Lincoln Dale <ltd@cisco.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <4.3.2.7.2.20010814155831.04b31220@mira-sjcm-3.cisco.com>
Message-ID: <Pine.LNX.4.33.0108151707540.19732-100000@monolith.shad0w.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Lincoln Dale wrote:

> netlink so as to allow user-space to receive the whole packet and avoid any
> processing in the kernel.

	Hmm, there's an idea.

> you may want to consider the same.  at least for cisco products, there are
[...]
> most of those kinds of policies are probably outside the scope of what
> logic you would expect in the kernel.

	I'm looking at doing something like you're doing, just need to
figure out which netlink family to use - ethertap seems overkill, is
adding a new family for CDP even more overkill?

> my $0.02 worth,

	Oooh, £0.20 at least :)

> cheers,

	Thanks for the ideas.  Don't 'spose you know anything about CDP v2
that someone mentioned? :)

-- 
Chris "_Shad0w_" Crowther
chrisc@shad0w.org.uk
http://www.shad0w.org.uk/

