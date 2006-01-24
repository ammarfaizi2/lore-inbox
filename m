Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWAXPNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWAXPNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWAXPNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:13:40 -0500
Received: from xenotime.net ([66.160.160.81]:34744 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030233AbWAXPNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:13:39 -0500
Date: Tue, 24 Jan 2006 07:13:37 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alex Riesen <raa.lkml@gmail.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to discover new Linux features (was: Re: Linux 2.6.16-rc1)
In-Reply-To: <81b0412b0601232316h6a26b083oab0b6d8de15e4c95@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0601240712300.5978@shark.he.net>
References: <200601182323_MC3-1-B627-7710@compuserve.com>
 <81b0412b0601232316h6a26b083oab0b6d8de15e4c95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2006, Alex Riesen wrote:

> On 1/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >  Say you are comparing kernels 2.6.14 and 2.6.15, trying to see what
> > is new.  Just do this:
> >
> >  1.  Copy a .config file into your 2.6.14 directory.
> >
> >  2.  Run "make oldconfig" there.  It doesn't really matter what
> >      answers you give so long as it runs to completion.
>
> make it "make allconfig"

Are you suggesting a new make target?  'make help' lists
allyesconfig, allnoconfig, or allmodconfig (in the all* group).

-- 
~Randy
