Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274820AbTHGAzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHGAzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:55:51 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:15355 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S274820AbTHGAzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:55:50 -0400
Message-ID: <3F31A379.2060807@tequila.co.jp>
Date: Thu, 07 Aug 2003 09:55:21 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: Mike Fedyk <mfedyk@matchmail.com>, reiser@namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu>	<20030805224152.528f2244.akpm@osdl.org>	<3F310B6D.6010608@namesys.com>	<20030806183410.49edfa89.diegocg@teleline.es>	<20030806180427.GC21290@matchmail.com> <20030806204514.00c783d8.diegocg@teleline.es>
In-Reply-To: <20030806204514.00c783d8.diegocg@teleline.es>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Diego Calleja García wrote:

> El Wed, 6 Aug 2003 11:04:27 -0700 Mike Fedyk <mfedyk@matchmail.com>
escribió:
>
>
>>Journaled filesystems have a much smaller chance of having problems
after a
>>crash.
>
> I've had (several) filesystem corruption in a desktop system with
(several)
> journaled filesystems on several disks. (They seem pretty stable these
days,
> though)

well, I only had one time huge problems with a journaling FS, this was
when I thought I could use Reise FS Beta on a Production File Server ;)

> However I've not had any fs corrution in ext2; ext2 it's (from my
experience)
> rock stable.

well, ever had a check of several hundrets of Gigabytes in ext2 after a
poweroutage ... when you had this several times in a row, you even take
ext3 and thank for its existence ...

> Personally I'd consider twice the really "serious" option for a
serious server.

I'd never use ext2 on a server anymore nowadays. You have so many
choises of stable journaling filesystems, you don't have to use ext2
anymore (except perhaps for small partitions like /tmp or /boot ...)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/MaN5jBz/yQjBxz8RAqEDAJ9MZBTBokLsCxDQga3GVNHKY9q/3ACgpX2S
nIezpbMMsLb58jTnYnHI53w=
=fO1v
-----END PGP SIGNATURE-----

