Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSKFPeX>; Wed, 6 Nov 2002 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSKFPeX>; Wed, 6 Nov 2002 10:34:23 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60801 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265705AbSKFPeW>; Wed, 6 Nov 2002 10:34:22 -0500
Date: Wed, 6 Nov 2002 10:41:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>
Subject: Re: Linux 2.4.20-rc1
In-Reply-To: <3DC43D86.5070608@gmx.net>
Message-ID: <Pine.LNX.4.44L.0211061033410.27268-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sat, 2 Nov 2002, Carl-Daniel Hailfinger wrote:

> Marcelo Tosatti wrote:
> > Hi,
> >
> > Finally, rc1.
> > [snipped]
> >
> > Please stress test it.
> >
>
> My system comes up with a blank console after hardware suspend and resume.
> The cursor is still visible, but no text is there. Switching to another
> console and back fixes it. Vesafb is enabled with vga=791.
> Hardware is a Toshiba Satellite 4100XCDT notebook with Trident Cyber9525DVD
> graphics chipset, but this also can be reproduced with Dell notebooks.
>
> I just verified the problem exists still with 2.4.20-rc1.
> A binary search turned up 2.4.18-pre7 as the kernel which broke,
> specifically the changes made to apm.c back then.

Have you tried to revert 2.4.18-pre7's changes to apm.c to make sure it is
the cause?>

Stephen, can you please take a look at this for me?

