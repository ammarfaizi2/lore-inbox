Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSCDADT>; Sun, 3 Mar 2002 19:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSCDADK>; Sun, 3 Mar 2002 19:03:10 -0500
Received: from sebula.traumatized.org ([193.121.72.130]:35522 "EHLO
	sebula.traumatized.org") by vger.kernel.org with ESMTP
	id <S288058AbSCDAC4>; Sun, 3 Mar 2002 19:02:56 -0500
X-NoSPAM: http://traumatized.org/nospam/
Message-ID: <3C82A854.1080408@pophost.eunet.be>
Date: Sun, 03 Mar 2002 23:48:52 +0100
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux sparc64; en-US; rv:0.9.8) Gecko/20020220
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre2: ufs problems
In-Reply-To: <20020301114238.A28655@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

> 2.4.19-pre2 fails to mount my FreeBSD filesystems:
> 
> bogomips root ~# grep bsd /etc/fstab
> /dev/hda10              /bsd            ufs     ro,ufstype=44bsd 0 0
> /dev/hda12              /bsd/var        ufs     ro,ufstype=44bsd 0 0
> /dev/hda13              /bsd/usr        ufs     ro,ufstype=44bsd 0 0
> bogomips root ~# mount -a
> UFS: failed to set blocksize
> mount: wrong fs type, bad option, bad superblock on /dev/hda10,
>        or too many mounted file systems
> mount: mount point /bsd/var does not exist
> mount: mount point /bsd/usr does not exist

FWIW; i get the same trying to mount my Solaris partitions.

# mount -t ufs -r -o ufstype=sun /dev/hda4 /mnt
mount: wrong fs type, bad option, bad superblock on /dev/hda4,
        or too many mounted file systems

in my `dmesg` output, i get:
UFS: failed to set blocksize


Jurgen.

