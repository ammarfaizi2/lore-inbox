Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbTBGEBM>; Thu, 6 Feb 2003 23:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTBGEBM>; Thu, 6 Feb 2003 23:01:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13331 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267554AbTBGEBL>;
	Thu, 6 Feb 2003 23:01:11 -0500
Date: Thu, 6 Feb 2003 20:06:06 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Restore module support.
Message-ID: <20030207040606.GA30337@kroah.com>
References: <20030204233310.AD6AF2C04E@lists.samba.org> <Pine.LNX.4.44.0302062358140.32518-100000@serv> <20030206232515.GA29093@kroah.com> <Pine.LNX.4.44.0302070037230.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302070037230.32518-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 01:01:01AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 6 Feb 2003, Greg KH wrote:
> 
> > But what are the modutils numbers? :)
> 
> There should be no real difference as I'd like to integrate Kai's patch too.

Ok, I'm confused, you're advocating putting back the old modutils
interface, but somehow not using the old modutils code?  I don't
understand.


> > Come on, what Rusty did was the "right thing to do" and has made life
> > easier for all of the arch maintainers (or so says the ones that I've
> > talked to), and has made my life easier with regards to
> > MODULE_DEVICE_TABLE() logic, which will enable the /sbin/hotplug
> > scripts/binary to shrink a _lot_.
> 
> What was the "right thing to do"?
> There were certainly a few interesting changes, but I'd like discuss them 
> first. For example there is more than one solution to improve the 
> MODULE_DEVICE_TABLE() logic (*), so how is Rusty's better?

Neither one of those proposals, no any others, were backed with working
examples.  Rusty had the only working example of getting rid of the
userspace knowledge of the kernel data structures that I know of so far.

thanks,

greg k-h
