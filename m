Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSFEEBo>; Wed, 5 Jun 2002 00:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSFEEBn>; Wed, 5 Jun 2002 00:01:43 -0400
Received: from dsl-213-023-043-246.arcor-ip.net ([213.23.43.246]:32439 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317541AbSFEEBn>;
	Wed, 5 Jun 2002 00:01:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, Karim Yaghmour <karim@opersys.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 06:00:46 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020604161001.K36@toy.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FRyZ-0001UL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 18:10, Pavel Machek wrote:
> > 5) Drivers who require absolute priority and dislike other kernel
> > portions who use cli/sti can now create a domain of their own
> > and place themselves before Linux in the ipipe. This provides a
> > mechanism for the implementation of systems that can provide guaranteed
> > realtime response.
> 
> This is same approach rtLinux takes, right?

It accomplishes the same thing in a different way.  Karim's interrupt
pipline approach also exposes some interesting new capabilities to the
client operating systems.  The ability to add/remove clients from the
pipeline seems very powerful.

-- 
Daniel
