Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRKDRtK>; Sun, 4 Nov 2001 12:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKDRst>; Sun, 4 Nov 2001 12:48:49 -0500
Received: from unthought.net ([212.97.129.24]:48344 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S280970AbRKDRsk>;
	Sun, 4 Nov 2001 12:48:40 -0500
Date: Sun, 4 Nov 2001 18:48:39 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104184839.F14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <160QM5-1HAz5sC@fmrl00.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 05:45:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 05:45:45PM +0100, Tim Jansen wrote:
> On Sunday 04 November 2001 16:33, you wrote:
> > Maintaining the current /proc files is very simple, and it offers the
> > system administrator a lot of functionality that isn't reasonable to take
> > away now.
> >        * They should stay in a form close to the current one *
> 
> I doubt that it is worthwhile to keep them in the current form for any other 
> reason than compatibility (with existing software and people's habits). 

It's an essential feature for *many* sysadmins.  It's just so *easy* to hack
up a script to act on the information in some file - or to take a look with
"cat" to see how you RAID resync is coming along.

> It doesn't make sense to describe things in 200 different formats, you won't 
> help anybody with that. It also violates the good old principle of keeping 
> policy out of the kernel. And, for me, layout is clearly policy.

User-readable,  and machine-readable.   I think that covers everything. And
that's two formats.

Where's the policy ?   The only policy I see is the text-mode GUI in the
existing proc interface - and that is one place where I actually *like* the
policy as a user (sysadmin), but hate it as an application programmer.

> 
> The reason for proc's popularity is clearly that you can use any tool, from 
> cat over more/less to the text editor of choice, and read the files.

That's the reason why I want to keep the old proc files.

> There 
> should be ways to achieve this without putting things into the kernel.  Is 
> there is a way to implement a filesystem in user-space? What you could do is 
> to export the raw data using single-value-files, XML or whatever and then 
> provide an emulation of the old /proc files and possibly new ones in user 
> space. This could be as simple as writing a shell-script for each emulated 
> file.

You're proposing a replacement of /proc ?

My proposal was at least intended to be very simple and non-intrusive.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
