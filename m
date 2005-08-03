Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVHCN6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVHCN6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVHCN5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:57:45 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:48403 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262137AbVHCN5N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o00D0+NKihcTPpYr8v8Zd+vC5BkN/IByoGQEEowUugRrIKDByhyITOSFVhUnpBXir7b3ql0xYoSCbDnCjrJz/Yp51N/cVHGweK9IO/SAZSplVH+IxVhZh6wOm5W45UCzerNJkqArZbdsb3LTvYVrEDyE9Oo5qfJ+8+vqt7Oesp0=
Message-ID: <d120d50005080306575372d990@mail.gmail.com>
Date: Wed, 3 Aug 2005 08:57:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hans Kristian Rosbach <hans.kristian@isphuset.no>
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Cc: James Bruce <bruce@andrew.cmu.edu>, "Theodore Ts'o" <tytso@mit.edu>,
       David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1123060790.29553.7.camel@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730195116.GB9188@elf.ucw.cz>
	 <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu>
	 <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se>
	 <42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org>
	 <42EEFB9B.10508@andrew.cmu.edu> <1123060790.29553.7.camel@linux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/05, Hans Kristian Rosbach <hans.kristian@isphuset.no> wrote:
> On Tue, 2005-08-02 at 00:50 -0400, James Bruce wrote:
> > Theodore Ts'o wrote:
> >  > On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
> >  >>The tradeoff is a realistic 4.4% power savings vs a 300% increase in
> >  >>the minimum sleep period.  A user will see zero power savings if they
> >  >>have a USB mouse (probably 99% of desktops).  On top of that, we can
> >                                      ^^^^^^^^
> >
> >  > Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
> >  > the places where power consumption savins matters most, it's usually
> >  > quite possible to function without needing any USB devices.  The 90%
> >  > figure isn't at all right; in fact, it may be that over 90% of the
> >  > laptops still use PS/2 mice and keyboards.
> >
> > Yes, laptops are mostly PS/2, which is why I only claimed a statistic
> > for desktops.  Desktops pretty much all use USB mice now.  If 250Hz were
> > only being sold as an option for laptops, we could leave it at that, yet
> > its being pushed as a default that's "good for everyone".  For desktops
> > this is not currently true at all.  By the time USB is fixed to do power
> > saving, we'll probably have a working tick-skipping patch which makes
> > the whole HZ argument moot.
> 
> Most new laptops are moving away from PS/2 ports, for example my
> shining (literally) new Acer Ferrari 4005 only has USB2 ports for mice
> and keyboard inputs (unless in the optional pcie docking station maybe).
> So my suggestion would be to fix USB power management.
>

You are talking about external ports. I am pretty sure that installed
keyboard and touchpad (or whattever pointing device it has) are plain
old PS/2.

-- 
Dmitry
