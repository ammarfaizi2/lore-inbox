Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTBFXUL>; Thu, 6 Feb 2003 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTBFXUL>; Thu, 6 Feb 2003 18:20:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47122 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267615AbTBFXUK>;
	Thu, 6 Feb 2003 18:20:10 -0500
Date: Thu, 6 Feb 2003 15:25:15 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Restore module support.
Message-ID: <20030206232515.GA29093@kroah.com>
References: <20030204233310.AD6AF2C04E@lists.samba.org> <Pine.LNX.4.44.0302062358140.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302062358140.32518-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 12:09:27AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Tue, 4 Feb 2003, Rusty Russell wrote:
> 
> > I'm going to stop here, since I don't think you understand what I am
> > proposing, nor how the current system works: this makes is extremely
> > difficult to describe changes, and time consuming.
> 
> Rusty, if you continue to ignore criticism, I have only one answer left:
> 
> http://www.xs4all.nl/~zippel/restore-modules-2.5.59.diff

But what are the modutils numbers? :)

Come on, what Rusty did was the "right thing to do" and has made life
easier for all of the arch maintainers (or so says the ones that I've
talked to), and has made my life easier with regards to
MODULE_DEVICE_TABLE() logic, which will enable the /sbin/hotplug
scripts/binary to shrink a _lot_.

thanks,

gre gk-h
