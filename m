Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVK2Uxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVK2Uxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVK2Uxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:53:55 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51381
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932384AbVK2Uxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:53:54 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Nix <nix@esperi.org.uk>
Subject: Re: Question: madvise(DONT_SYNC)
Date: Tue, 29 Nov 2005 14:06:17 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200511271925.09565.rob@landley.net> <87y837s8hn.fsf@amaterasu.srvr.nix>
In-Reply-To: <87y837s8hn.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291406.18138.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 10:51, Nix wrote:
> On 28 Nov 2005, Rob Landley whispered secretively:
> > I can change the default to /dev/pts (which is tmpfs with the sticky bit
> > on Fedora Core 4, Ubuntu, and Gentoo.
>
> Um, you mean /dev/shm, right?

Yes. :)

> >                                     But which has nothing mounted on it
> > and isn't even world writable on the only x86-64 system I currently have
> > access
>
> Well, shm_open() and friends just won't work on that system (the /dev/shm
> path is hardwired into glibc; I guess the PLD people might have hacked
> glibc to change that path, but that seems peculiar).
>
> Distro bug.

Yup.  I agree that's a distro bug.  (Or possibly the one system I have access 
to is uniquely broken.)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
