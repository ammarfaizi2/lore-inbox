Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRKAQXB>; Thu, 1 Nov 2001 11:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279227AbRKAQWw>; Thu, 1 Nov 2001 11:22:52 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:44528 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S279190AbRKAQWk>; Thu, 1 Nov 2001 11:22:40 -0500
Date: Thu, 1 Nov 2001 16:21:43 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Peter Jones <pjones@redhat.com>
cc: Alex Buell <alex.buell@tahallah.demon.co.uk>,
        Paul Mackerras <paulus@samba.org>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
In-Reply-To: <Pine.LNX.4.33.0111011053140.9216-100000@lacrosse.corp.redhat.com>
Message-ID: <Pine.LNX.4.33.0111011621070.2281-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Peter Jones wrote:

> > Ah, is that what it does. OK, I'll carefully suggest to the authors of ESD
> > (preferably with a blunt trauma instrument) using AFMT_S16_NE. Thanks.

> It should probably be mentioned that you're using a really old version
> of ESD, and that they've at least made it so that you'll get the right
> one for any BE machine.  NE is still the better answer though -- now
> their configure script figures out BE/LE, and it'll build wrong if
> you're crosscompiling.

But this version I'm using is esound-2.2.8, which came from www.gnome.org!
I suppose I'll have to grab it from their CVS server.

-- 
Come the revolution, humourless gits'll be first up against the wall.

http://www.tahallah.demon.co.uk

