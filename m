Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313118AbSDDI7m>; Thu, 4 Apr 2002 03:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313117AbSDDI7c>; Thu, 4 Apr 2002 03:59:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:55794 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313114AbSDDI7R> convert rfc822-to-8bit; Thu, 4 Apr 2002 03:59:17 -0500
Date: Thu, 4 Apr 2002 10:57:40 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 mount.smbfs oops
In-Reply-To: <3CABA4FE.2835A5A8@sandino.net>
Message-ID: <Pine.NEB.4.44.0204041054290.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Sandino Araico Sánchez wrote:

> 1. mount -t smbfs -o uid=500,gid=500 //blue/shared-dir /mnt/smb
>     The smbmount asked me for a password, I pressed enter
> 2. df
>     Nothing strange happens
> 3. ls /mnt/smb
>     The Oops happens.
>
> The Windows machine is Windows Xp, the ksymoops output attached.

This sounds like the nls bug. In this case a patch is at
  http://www.hojdpunkten.ac.se/054/samba/00-smbfs-2.4.18-codepage.patch.gz


> Sandino Araico Sánchez

cu
Adrian



