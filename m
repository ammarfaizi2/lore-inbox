Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbSKQDIN>; Sat, 16 Nov 2002 22:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbSKQDIN>; Sat, 16 Nov 2002 22:08:13 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:20495 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S267437AbSKQDIM>; Sat, 16 Nov 2002 22:08:12 -0500
Date: Sat, 16 Nov 2002 22:18:01 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: romieu@fr.zoreil.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
In-Reply-To: <20021117010801.A21229@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0211162216100.18649-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2002 romieu@fr.zoreil.com wrote:

> [Cc trimmed]
>
> Dan Kegel <dank@kegel.com> :
> [...]
> > So how 'bout this:
> >
> > * mark all drivers that don't compile OBSOLETE.  That keeps us from
> >    trying to fix drivers without having hardware to test them.
> >    Anyone with proper hardware is invited to fix the drivers and then
> >    mark them non-OBSOLETE.
>
> Plain old #warning doesn't work that bad and requires 0 extra new feature.

I think there needs to be some sort of warning during the configuration
process - people will discover that a driver doesn't compile when they get
a screenfull of gcc errors and make halts compiling, they shouldn't need a
#warning to figure that out.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu


