Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132619AbRC1Xtr>; Wed, 28 Mar 2001 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbRC1Xth>; Wed, 28 Mar 2001 18:49:37 -0500
Received: from 139.loud-n-clear.net ([195.149.39.139]:45728 "EHLO
	pyramint.emcuk.com") by vger.kernel.org with ESMTP
	id <S132619AbRC1XtW>; Wed, 28 Mar 2001 18:49:22 -0500
Date: Thu, 29 Mar 2001 00:47:40 +0100
From: Tim Haynes <kernel@vegetable.org.uk>
To: Hacksaw <hacksaw@hacksaw.org>
Cc: Andreas Rogge <lu01@rogge.yi.org>, james <jdickens@ameritech.net>,
   linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem
Message-ID: <20010329004740.M28274@emcuk.com>
In-Reply-To: <64000000.985795007@hades> <200103282333.f2SNX4Q06854@habitrail.home.fools-errant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200103282333.f2SNX4Q06854@habitrail.home.fools-errant.com>; from hacksaw@hacksaw.org on Wed, Mar 28, 2001 at 06:33:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 06:33:04PM -0500, Hacksaw wrote:

> > Anyone working as root is (sorry) an idiot! root's processes are normally
> > quite system-relevant and so they should never be killed, if we can avoid 
> > it.
> 
> The real world intrudes. Root sometimes needs to look at documentation,
> which, these days is often available as html. Sometimes it's only as html.
> And people in a panic who aren't trained sys-admins aren't going to remember
> to log in as someone else.

Why are they logged in as root in the first place? Is there something they
can't do over sudo?
I definitely remember seeing a document saying `if you find yourself needing to
`man foo', do it in another terminal as your non-root self'; it might or might
not've been the SAG.

In any case, what happened to `if you use this rope you will hang yourself'?
There has to be a point where you abandon catering for all kinds of fool and
get on with writing something useful, I think.

> I completely agree that doing general work as root is a bad idea. I do most
> root things via sudo. It sure would be nice if all the big dists supplied it
> (Hey, RedHat! You listening?) as part of their normal set.

RH have been listening since v7.0.

~Tim
