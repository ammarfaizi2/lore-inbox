Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314637AbSEYO0z>; Sat, 25 May 2002 10:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314641AbSEYO0y>; Sat, 25 May 2002 10:26:54 -0400
Received: from jwhite-home.codeweavers.com ([209.240.253.22]:40816 "EHLO
	jwhiteh.whitesen.org") by vger.kernel.org with ESMTP
	id <S314637AbSEYO0x>; Sat, 25 May 2002 10:26:53 -0400
Subject: Re: isofs unhide option:  troubles with Wine
From: Jeremy White <jwhite@codeweavers.com>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251513280.10327-100000@sharra.ivimey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 May 2002 09:25:03 -0500
Message-Id: <1022336704.1655.3.camel@jwhiteh>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAIK, Windows "hidden" files are supposed to behave much like Unix 'dot' 
> files (.login, etc), so IMO the kernel should not use the hidden bit at all. 
> Instead, it should be 'ls' et al that do this. Now, I guess this isn't 
> particularly practical without changing fileutils and many other things, so I 
> would suggest that the kernel is changed to pass on, if possible, but 
> basically ignore the 'hidden' bit.

To me, this seems like the best approach.  My solution offends my
sensibilities in that we essentially 'throw away' the hidden
bit information.  However, I am sufficiently ignorant of the
filesystem such that I don't really know if this is feasible,
or if there is even a reasonable place to park the hidden bit
information.

Cheers,

Jer


