Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUJHEgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUJHEgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 00:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUJHEgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 00:36:45 -0400
Received: from nabe.tequila.jp ([211.14.136.221]:30899 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S267521AbUJHEgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 00:36:43 -0400
Message-ID: <41661950.5070508@tequila.co.jp>
Date: Fri, 08 Oct 2004 13:36:32 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Dickson <SteveD@redhat.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS using CacheFS
References: <4161B664.70109@RedHat.com>
In-Reply-To: <4161B664.70109@RedHat.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/05/2004 05:45 AM, Steve Dickson wrote:

| 3) There is no user level support. I realize this is extremely cheesy
|     but I noticed that the NFS posix mount  option (in the 2.6 kernel)
|     was no longer being used, so I high jacked it.  Which means
|     to make NFS to used CacheFS you need to use the posix option:
|
|     mount -o posix server:/export/home /mnt/server/home

brr :) why is it posix, this is so out of the context for me (as a
user). Is it possible to have a cachefs flag. Would make it more logical.

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBZhlPjBz/yQjBxz8RAtKbAKCLWJBqWQUcroSaLzlrH1r2nuqI8gCfUzyL
kpANJQ4pYt1026VBRm8UlpU=
=NGFC
-----END PGP SIGNATURE-----
