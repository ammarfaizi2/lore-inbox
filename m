Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUKFIi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUKFIi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 03:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKFIi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 03:38:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2564 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261335AbUKFIi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 03:38:56 -0500
Date: Sat, 6 Nov 2004 09:38:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Grzegorz Kulewski'" <kangur@polcom.net>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Adam Heath'" <doogie@debian.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041106083824.GB783@alpha.home.local>
References: <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net> <200411052208.ATT88180@mira-sjc5-e.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411052208.ATT88180@mira-sjc5-e.cisco.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 02:08:45PM -0800, Hua Zhong wrote:
> At least in 2.4.17 I couldn't loopback mount an (ext2) image from tmpfs and
> had to use ramfs. Has this been fixed?

I believe it works now (2.4.27) but at least some external add-ons such as
Tux cannot serve pages on tmpfs but are OK on ramfs. What would be needed
is a ramfs with a size limit.

Willy

