Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264602AbRFPKKx>; Sat, 16 Jun 2001 06:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264603AbRFPKKn>; Sat, 16 Jun 2001 06:10:43 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:56580 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S264602AbRFPKKc>;
	Sat, 16 Jun 2001 06:10:32 -0400
Date: Thu, 14 Jun 2001 13:12:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sven Geggus <geg@iitb.fhg.de>, linux-kernel@vger.kernel.org
Subject: Re: Changing CPU Speed while running Linux
Message-ID: <20010614131220.A36@toy.ucw.cz>
In-Reply-To: <20010613143536.A1323@iitb.fhg.de> <3B2768E1.2B7E064C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B2768E1.2B7E064C@redhat.com>; from arjanv@redhat.com on Wed, Jun 13, 2001 at 02:21:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > on my Elan410 based System it is very easy to change the CPU clock speed by
> > means od two outb commands.
> > 
> > I was wondering, if it does some harm to the Kernel if the CPU is
> > reprogrammed using a different CPU clock speed, while the system is up and
> > running.
> 
> I have a module for the K6 PowerNow which allows you to do
> 
> echo 450 > /proc/sys/cpu/0/frequency
> 
> and does the right thing wrt udelay / bogomips etc..
> I can dig it out if you want.. sounds like this should be a more generic
> thing.

Can you dig that out? I'd like to take a look.

[Of course, problem is *not* solved: you still have short time when
kernel runs with wrong bogomips.]

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

