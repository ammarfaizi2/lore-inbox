Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbTCGXzN>; Fri, 7 Mar 2003 18:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261943AbTCGXzN>; Fri, 7 Mar 2003 18:55:13 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27660 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261937AbTCGXzH>;
	Fri, 7 Mar 2003 18:55:07 -0500
Date: Fri, 7 Mar 2003 15:55:36 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030307235536.GH21315@kroah.com>
References: <20030307233653.GD21315@kroah.com> <Pine.LNX.4.44.0303071551410.1496-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303071551410.1496-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:53:44PM -0800, Linus Torvalds wrote:
> > But a lot of code that will need klibc, has not been converted to need
> > it yet, due to it not being there :)
> 
> Yes. But that's not an argument that flies with me. I really want to see 
> people actually using it, for real issues (even if they are potentially 
> _small_ real issues).

Fair enough, I'll go work on this.

In the meantime, there were a number of fixes needed to the initramfs
code to get it to work properly for files.  Will you take those small
fixes now so that everyone else can also start to play with a real
initramfs image?

thanks,

greg k-h
