Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288499AbSAHWTq>; Tue, 8 Jan 2002 17:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288503AbSAHWTh>; Tue, 8 Jan 2002 17:19:37 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:18702 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288499AbSAHWT3>;
	Tue, 8 Jan 2002 17:19:29 -0500
Date: Tue, 8 Jan 2002 14:17:20 -0800
From: Greg KH <greg@kroah.com>
To: "Ian S. Nelson" <nelcomp@attglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020108221719.GA15986@kroah.com>
In-Reply-To: <3C3B664B.3060103@intel.com> <3C3B6BD2.9070201@attglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3B6BD2.9070201@attglobal.net>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 11 Dec 2001 20:13:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 02:59:46PM -0700, Ian S. Nelson wrote:
> 
> I suspect this might be about as religious an issue as there is but has 
> anyone thought about coming up with some "standard" debugging macros, 
> perhaps something that can be configured at compile time from the 
> configuration for everyone to use everywhere?  I've got my own debug 
> macros,  essentially a printk with the file, function and line added 
> wrapped in #ifdef DEBUG.  I've seen several other schemes in other parts 
> of the kernel and now some of them aren't correct.

Jeff Garzik and others have talked about unifying the network driver's
debug statements and levels with a common set of macros and level
values.  I want to do the same thing with the USB drivers, but was
waiting for them to finalize their scheme first (and hopefully use the
same thing.)

So yes, I think there can be some kind of "standard" debugging macros,
but the "standard" will probably be limited to a subset of the kernel.

greg k-h
