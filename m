Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293471AbSCFLXS>; Wed, 6 Mar 2002 06:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293478AbSCFLXI>; Wed, 6 Mar 2002 06:23:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43277 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293469AbSCFLWu>; Wed, 6 Mar 2002 06:22:50 -0500
Date: Wed, 6 Mar 2002 12:22:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Rakesh Kumar Banka <Rakesh@asu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Monolithic Vs. Microkernel
Message-ID: <20020306112240.GD27043@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020304144923.A96@toy.ucw.cz> <Pine.LNX.4.44L.0203051803120.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203051803120.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This means we can have all the advantages of modularity at the
> >
> > Not *all* of them. On vsta, you could do
> >
> > ( killall keyboard; sleep 1; keyboard ) &
> 
> How is that different from the following ?
> 
> (rmmod keyboard ; sleep 1 ; modprobe keyboard)
> 
> [no, no need to talk about hardware access ... vsta's keyboard
> driver also has hardware access]

Standart tools for standard tasks. And if there's while(1); in VSTa's
keyboard handler will not prevent killall.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
