Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRKSPdo>; Mon, 19 Nov 2001 10:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279472AbRKSPde>; Mon, 19 Nov 2001 10:33:34 -0500
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:37384 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S278940AbRKSPd2>;
	Mon, 19 Nov 2001 10:33:28 -0500
Date: Mon, 19 Nov 2001 07:36:25 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <01111917034005.00817@nemo>
Message-ID: <Pine.LNX.4.10.10111190731400.22578-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, vda wrote:

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
> --

/home/user/public_html

Apache needs to be able to access public_html but you really don't want
other users browsing your home dir.

This is in fact a VERY COMMON SETUP and several distros even set things up
that way by default. 

On top of that your proposed change would make linux diffrent from every
other Unix like OS making life harder for those of us who admin/code for 
several diffrent OS.

	Gerhard

 


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

