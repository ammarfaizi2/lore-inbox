Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284537AbRLESIQ>; Wed, 5 Dec 2001 13:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbRLESIG>; Wed, 5 Dec 2001 13:08:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1038 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284540AbRLESH4>; Wed, 5 Dec 2001 13:07:56 -0500
Date: Wed, 5 Dec 2001 14:51:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.30.0112051713200.2297-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.21.0112051450310.20481-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Dec 2001, Roy Sigurd Karlsbakk wrote:

> hi all
> 
> I've just upgraded to 2.4.16 to get /proc/sys/vm/(max|min)-readahead
> available. I've got this idea...
> 
> If lots of files (some hundered) are read simultaously, I waste all the
> i/o time in seeks. However, if I increase the readahead, it'll read more
> data at a time, and end up with seeking a lot less.
> 
> The harddrive I'm testing this with, is a cheap 20G IDE drive. It can give
> me a peak thoughput of about 28 MB/s (reading).
> When running 10 simultanous dd jobs ('dd if=filenr of=/dev/null bs=4m'), I
> peaks at some 8,5 MB/s no matter what I set the min/max readahead to!!
> 
> Is this correct?

Do you also have VM pressure going on or do you have lots of free memory ? 

