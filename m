Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285343AbRLSQAw>; Wed, 19 Dec 2001 11:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285339AbRLSQAl>; Wed, 19 Dec 2001 11:00:41 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:2835 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285345AbRLSQAh>; Wed, 19 Dec 2001 11:00:37 -0500
Date: Wed, 19 Dec 2001 12:46:00 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-rc2
In-Reply-To: <3C1FCE78.9F87D16D@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0112182230550.5026-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Dec 2001, Jeff Garzik wrote:

> Marcelo Tosatti wrote:
> > - Make some erroneously global spinlocks
> >   static                                        (David C. Hansen)
> 
> This is a release-candidate patch???   Looks like cleanup to me.

Jeff,

This patch is obviously correct and it cant break anything.

> > - More __devexit_p fixes                        (Daniel T. Chen)
> 
> This patch is 100% wrong.  The hardware is question is not hotplug
> hardware, so therefore should not be marked with __devexit.  I strongly
> urge that you revert this patch...  none of the affected drivers could
> be called popular at any rate.

Agreed. I'll remove it.


