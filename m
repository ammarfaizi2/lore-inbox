Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131996AbQKSA3j>; Sat, 18 Nov 2000 19:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbQKSA3a>; Sat, 18 Nov 2000 19:29:30 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:42000 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131996AbQKSA3S>;
	Sat, 18 Nov 2000 19:29:18 -0500
Date: Sun, 19 Nov 2000 01:53:00 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 sendfile() not doing as manpage promises?
Message-ID: <20001119015259.A10773@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001119001558.B10579@home.ds9a.nl> <Pine.LNX.4.30.0011181513290.5897-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.30.0011181513290.5897-100000@anime.net>; from goemon@anime.net on Sat, Nov 18, 2000 at 03:15:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 03:15:28PM -0800, Dan Hollis wrote:

> > In that case, the wording of the manpage needs to be changed, as it
> > implies that 'either or both' of the filedescriptors can be sockets.
> 
> Its quite clear.
> 
> DESCRIPTION
>        This  call copies data between file descriptor and another
>        file  descriptor  or  socket.   in_fd  should  be  a  file
>        descriptor   opened  for  reading.   out_fd  should  be  a
>        descriptor opened for writing or a connected socket.
> 
> in_fd must be a file, out_fd can be a file or socket.

My manpages must be outdated then, my manpage is from 1 Dec 1998. Thanks for
the correction.

Regards,

bert hubert


-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
