Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287449AbSAHAO7>; Mon, 7 Jan 2002 19:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSAHAOs>; Mon, 7 Jan 2002 19:14:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26376 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287449AbSAHAOl>; Mon, 7 Jan 2002 19:14:41 -0500
Date: Mon, 7 Jan 2002 21:01:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Error reading multiple large files
In-Reply-To: <Pine.LNX.4.30.0201071941100.13561-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.21.0201072100310.18722-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roy,

I suspect this is a use-once effect.

Could you please try http://surriel.com/patches/2.4/2.4.17-pre8-2ndchance
? 

Thanks

On Mon, 7 Jan 2002, Roy Sigurd Karlsbakk wrote:

> Hi all
> 
> I've sent this before, but as far as I can see, nothing's changed.
> 
> I'm having problems reading multiple large files at once. Reading 100 1GB
> files at once.
> 
> What happens is, when the buffer cache gets filled up, it all stalls, and
> transfer speed drops from 40-50 MB/s to a mere 2MB/s.


