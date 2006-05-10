Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWEJVsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWEJVsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWEJVsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:48:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22686 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965042AbWEJVsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:48:11 -0400
Date: Wed, 10 May 2006 22:48:04 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510214804.GG27946@ftp.linux.org.uk>
References: <Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com> <20060510162404.GR3570@stusta.de> <Pine.LNX.4.58.0605101506540.22959@gandalf.stny.rr.com> <1147290577.21536.151.camel@c-67-180-134-207.hsd1.ca.comcast.net> <Pine.LNX.4.58.0605101636580.22959@gandalf.stny.rr.com> <1147295515.21536.168.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060510212058.GE27946@ftp.linux.org.uk> <1147296822.21536.175.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060510213929.GF27946@ftp.linux.org.uk> <1147297555.21536.177.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147297555.21536.177.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:45:54PM -0700, Daniel Walker wrote:
> > One last time: your kind of patches actually increases the odds of new bug
> > staying unnoticed.
> 
> Your using kind of a broad brush .. What do you mean "your kind of
> patches" ?

"Just to make gcc STFU" variety you seem to be advocating in these threads.
