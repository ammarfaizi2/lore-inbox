Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbSKSUYf>; Tue, 19 Nov 2002 15:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKSUYf>; Tue, 19 Nov 2002 15:24:35 -0500
Received: from bitmover.com ([192.132.92.2]:14505 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267149AbSKSUYd>;
	Tue, 19 Nov 2002 15:24:33 -0500
Date: Tue, 19 Nov 2002 12:31:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
Message-ID: <20021119123115.C16028@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20021119201110.GA11192@mars.ravnborg.org> <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Nov 19, 2002 at 03:22:45PM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:22:45PM -0500, Richard B. Johnson wrote:
> On Tue, 19 Nov 2002, Sam Ravnborg wrote:
> 
> > Based on some initial work by Kai Germaschewski I have made a
> > working prototype of separate obj/src tree.
> > 
> > Usage example:
> > #src located in ~/bk/linux-2.5.sepobj
> > mkdir ~/compile/v2.5
> > cd ~/compile/v2.5
> > sh ../../kb/v2.5/kbuild
> 
> [SNIPPED...]
> 
> I have a question; "What problem is this supposed to solve?"
> This looks like a M$ism to me. Real source trees don't
> look like this. If you don't have write access to the source-
> code tree, you are screwed on a real project anyway. That's
> why we have CVS, tar and other tools to provide a local copy.

It can be really nice to maintain a bunch of different architectures at
the same time from the same tree.  It also makes it really easy to 
"clean" a tree.

On the other hand, I do wonder whether ccache could be used to get the
same effect.  Sam?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
