Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbRL2B3D>; Fri, 28 Dec 2001 20:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287047AbRL2B2z>; Fri, 28 Dec 2001 20:28:55 -0500
Received: from dsl-213-023-043-233.arcor-ip.net ([213.23.43.233]:43534 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287038AbRL2B2q>;
	Fri, 28 Dec 2001 20:28:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hetz Ben Hamo <hetz@kde.org>
Subject: Re: Serious VM problems (cont..)
Date: Sat, 29 Dec 2001 02:31:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16JzWl-0006iD-00@witch.dyndns.org> <E16K7em-0000Ba-00@starship.berlin> <E16K7dG-00070M-00@witch.dyndns.org>
In-Reply-To: <E16K7dG-00070M-00@witch.dyndns.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16K8LY-0000Bn-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 29, 2001 01:46 am, Hetz Ben Hamo wrote:
> Umm, did you read the text of this email? I specifically said I tried 
> 2.4.17.

Hit the wrong button, that mail was posted by accident ;)

Yes, there's a problem.  A bad object pointer was passed to 
kmem_cache_free_one, it looks like a bug.

> On Saturday 29 December 2001 02:47, Daniel Phillips wrote:
> > On December 28, 2001 05:06 pm, Hetz Ben Hamo wrote:
> > > Sorry,
> > >
> > > I forgot to mention my Linux: Redhat 7.2 + the official kernel 2.4.17 (I
> > > also tested 2.4.9-13 - same errors) + all the latest updates (including
> > > FAM 2.6.6), XFree 4.1.0-3, KDE 2.2.1...

--
Daniel
