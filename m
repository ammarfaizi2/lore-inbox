Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbVLJUWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVLJUWS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbVLJUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 15:22:18 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:53809 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1161059AbVLJUWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 15:22:17 -0500
X-ME-UUID: 20051210202205844.CE2811FFFD25@mwinf0102.wanadoo.fr
Message-ID: <439B3969.20202@wanadoo.fr>
Date: Sat, 10 Dec 2005 21:24:09 +0100
From: mahashakti89 <mahashakti89@wanadoo.fr>
Reply-To: mahashakti89@wanadoo.fr
Organization: none
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev problem ...
References: <439A9973.6050009@wanadoo.fr> <20051210181640.GA8245@kroah.com>
In-Reply-To: <20051210181640.GA8245@kroah.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH a écrit :
> On Sat, Dec 10, 2005 at 10:01:39AM +0100, mahashakti89 wrote:
> 
>>Hi !
>>
>>Here is a report bug I posted on bugs@debian.org , we'll make it short ,
>>I cannot activate udev at boot , if I do this  I get IDE errors on both
>>harddisks and if I can enter an X-session, I cannot open a terminal : I
>>get following error message :
>>"there was a problem with the child process of this terminal" . If I
>>desactivate udev at boot, eveything is going O.K.
>>The Debian package maintainer thinks it looks like a kernel bug ....
>>This is why I am posting here hoping for help in this matter.
> 
> 
> Can you try the 2.6.15-rc5 kernel release to see if this is better?
> 
> thanks,
> 
> greg k-h
> 
> 
I did it, but it is not better ..... but perhaps due to an upgrade on my
debian Sid it seems
that I have not so much IDE errors but this impossibility to open any
terminal is already here ...

I tried one Debian pre-packaged kernel and it works , I mean nearly no
IDE errors
and no more problems with opening gnome-terminal, so it would mean that
here is a problem
in my kernel config ??

Here is an extract of the - so mentioned in the doc - important settings :

# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_RELAYFS_FS is not set


Where should I look to solve it definetely ??

Thanks for your answer.

mahashakti89

Hope there is no problem if I CC you this message ..
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmzlpPPuyRSaD7LoRAnguAJ9qktzBbdMdSErbGv+H9Fn33kZrxwCfYZhw
ND2wNBura+nQ+e6IZ78M97k=
=UteB
-----END PGP SIGNATURE-----

