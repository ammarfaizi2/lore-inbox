Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282296AbRKWXyf>; Fri, 23 Nov 2001 18:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282295AbRKWXy0>; Fri, 23 Nov 2001 18:54:26 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:21891 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S282289AbRKWXyL>; Fri, 23 Nov 2001 18:54:11 -0500
Date: Fri, 23 Nov 2001 18:54:07 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Flavio Stanchina <flavio.stanchina@tin.it>, linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123185407.A3499@alcove.wittsend.com>
Mail-Followup-To: Flavio Stanchina <flavio.stanchina@tin.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20212.1006507727@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain> <20011123094313.GB190@tolot.miese-zwerge.org> <20011123103338.BXVP10632.fep40-svc.tin.it@there> <20011123110505.A27707@alcove.wittsend.com> <20011123130820.D17332@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011123130820.D17332@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 01:08:20PM -0800, Mike Fedyk wrote:
> On Fri, Nov 23, 2001 at 11:05:05AM -0500, Michael H. Warfield wrote:
> > On Fri, Nov 23, 2001 at 11:33:38AM +0100, Flavio Stanchina wrote:
> > > On Friday 23 November 2001 10:43, Jochen Striepe wrote:
> > > 
> > > > I am *much* more irritated by:
> > > >
> > > > $ uname -r
> > > > 2.4.15-greased-turkey
> > 
> > > So I guess you are vegetarian. Try changing to "2.4.15-tasteful-salad".
> > 
> > 	Point is that it BROKE some things....  Like "make install" on
> > RedHat installed the damn thing as /boot/vmlinuz-2.4.15-greased-turkey,
> > breaking the lilo settings if you set an image for "vmlinuz-2.4.15"
> > like you expected it to be.  Not funny.  Just had three freeswan
> > kinstall builds blow up because of that.
> > 
> > 	Now got to go back and fix it and rebuild.

> OMFG!

> How can you *not* point to the /boot/vmlinuz symlink?!!!  It points directly
> to the latest kernel. And, /boot/vmlinuz.old points to the previous kernel.

	Clue alert...

	The PRIMARY link goes to vmlinuz.  The backup links go to the
specific versions (the install script even facilitates this for you
by installing it there).  That way, when you end up with a radioactive
version, you can boot your prior version and recover from the disaster.

> Here are some examples:  This is *just too simple*!!!

	I typically keep 4 to six fall back versions in each of the
2.2 and 2.4 lines active and want (or occasionally need) to target specific
versions, especially when I'm testing preX kernels and my device driver.
You are way TOO simple.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
