Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRKSPIe>; Mon, 19 Nov 2001 10:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279233AbRKSPIO>; Mon, 19 Nov 2001 10:08:14 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:34065 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S279228AbRKSPIK>;
	Mon, 19 Nov 2001 10:08:10 -0500
Subject: Re: x bit for dirs: misfeature?
From: Shaya Potter <spotter@cs.columbia.edu>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <01111917034005.00817@nemo>
In-Reply-To: <Pine.GSO.4.21.0111190927100.17210-100000@weyl.math.psu.edu> 
	<01111917034005.00817@nemo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1 (Preview Release)
Date: 19 Nov 2001 10:07:30 -0500
Message-Id: <1006182451.4633.5.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-19 at 12:03, vda wrote:
> On Monday 19 November 2001 14:46, Alexander Viro wrote:
> > On Mon, 19 Nov 2001, vda wrote:
> > > Everytime I do 'chmod -R a+rX dir' and wonder are there
> > > any executables which I don't want to become world executable,
> > > I think "Whatta hell with this x bit meaning 'can browse'
> > > for dirs?! Who was that clever guy who invented that? Grrrr"
> > >
> > > Isn't r sufficient? Can we deprecate x for dirs?
> > > I.e. make it a mirror of r: you set r, you see x set,
> > > you clear r, you see x cleared, set/clear x = nop?
> >
> > See UNIX FAQ.  Ability to read != ability to lookup.
> >
> > Trivial example: you have a directory with a bunch of subdirectories.
> > You want owners of subdirectories to see them.  You don't want them
> > to _know_ about other subdirectories.
> 
> Security through obscurity, that is.
> 
> Do you have even a single dir on your boxes with r!=x?

I've seen this a lot with html directories for web servers.


