Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSJJRXn>; Thu, 10 Oct 2002 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261710AbSJJRXn>; Thu, 10 Oct 2002 13:23:43 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:35076 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261705AbSJJRXm>;
	Thu, 10 Oct 2002 13:23:42 -0400
Date: Thu, 10 Oct 2002 19:29:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021010192924.A13618@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0210100035210.338-100000@serv> <3DA58C1E.3090102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA58C1E.3090102@pobox.com>; from jgarzik@pobox.com on Thu, Oct 10, 2002 at 10:18:06AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc: trimmed]

On Thu, Oct 10, 2002 at 10:18:06AM -0400, Jeff Garzik wrote:
> Personally I don't care about Config dependency checking...  they are 
> not modified often enough to affect me, and even if they did, dependency 
> checking based on changes to Config files can get ugly, AFAICS.  I just 
> do a "bk -r co -Sq" and am done with it...
I care a lot about Config dependency checking, and you are not within the 
group of people that I care about in this respect.

kernel-hackers has no problem realising that a "make oldconfig" is needed.

But I care about NN that follows 2.6 development, and update his/her
tree each time a new version is posted at kernel.org.
This group of people needs dependency checking on Config files -
as can be seen by the number of reports that boils down to
"run make oldconfig".
Which we btw. have not seen the last couple of weeeks, but I still think
is good.

	Sam
