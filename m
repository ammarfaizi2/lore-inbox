Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311635AbSC2TAk>; Fri, 29 Mar 2002 14:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSC2TAb>; Fri, 29 Mar 2002 14:00:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19072 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S311594AbSC2TAR>; Fri, 29 Mar 2002 14:00:17 -0500
Date: Fri, 29 Mar 2002 14:01:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cus.cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <20020329184906.GH8627@matchmail.com>
Message-ID: <Pine.LNX.3.95.1020329135900.1555A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Mike Fedyk wrote:

> On Fri, Mar 29, 2002 at 09:13:38AM -0500, Richard B. Johnson wrote:
> > If the files are NOT set to 'executable' as read by Linux, then samba
> > will not work. For the files to be visible to WIN/Clients, they
> > must have all bits set. This 'feature' can be used to make DOS/Win
> > files temporarily off-limits to WIN/Clients (like during a backup).
> >
> 
> Since when?
> 
> None of the of the data files on my samba server are marked executable, and
> all are readable.
> 
> You probably have "map archive = yes" in mind, but that will *not*
> deny access if
> the executable bit is set or not...
> 
> This is looking at the manual for smb.conf in 2.2.3a.
> 
> Mike
> 

Try it before you complain. I have samba servers all over the place.
If you have a DOS or VFAT file-system mounted and it is accessed by
samba as a "share", only the files that are executable will be seen
by the clients. Check it out.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

