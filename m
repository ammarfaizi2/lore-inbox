Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310196AbSCEU2a>; Tue, 5 Mar 2002 15:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293444AbSCEUZq>; Tue, 5 Mar 2002 15:25:46 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:33807 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310189AbSCEUY5>;
	Tue, 5 Mar 2002 15:24:57 -0500
Date: Mon, 4 Mar 2002 14:49:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Rakesh Kumar Banka <Rakesh@asu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Monolithic Vs. Microkernel
Message-ID: <20020304144923.A96@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0202252301510.24728-100000@general3.asu.edu> <Pine.LNX.4.33L.0202260844260.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0202260844260.7820-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Feb 26, 2002 at 08:45:29AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Anyone working on the Microkernel implementation
> > of Linux? Specially in the area of seperating the process
> > and the file management activities out of the kernel.
> 
> You have to remember that the source code for Linux is available.
> 
> This means we can have all the advantages of modularity at the

Not *all* of them. On vsta, you could do

( killall keyboard; sleep 1; keyboard ) &

to change your keymap. On linux you need special tools for managing
modules and are not protected from module bugs. Try developing filesystem
on production box.... You can do that on u-kernels.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

